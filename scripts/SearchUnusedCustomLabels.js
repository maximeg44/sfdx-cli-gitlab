const fs = require('fs'); //npm install fs xml2js glob axios
const xml2js = require('xml2js');
const glob = require('glob');
const axios = require('axios');

function postComment(projectId, mergeRequestId, comment, token) {
	const url = `https://gitlab.com/api/v4/projects/${projectId}/merge_requests/${mergeRequestId}/discussions`;
	const headers = { 'PRIVATE-TOKEN': token };
	const data = { body: comment };
	return axios.post(url, data, { headers });
}

const filePath = "force-app/main/default/labels/CustomLabels.labels-meta.xml";
const directories = ["force-app/main/default/lwc", "force-app/main/default/flows", "force-app/main/default/classes", "force-app/main/default/email", "force-app/main/default/aura", "force-app/main/default/flexipages", "force-app/main/default/quickActions", "force-app/main/default/objects", "force-app/main/default/pages", "force-app/main/default/staticresources"];
let counter = 0;
let unusedLabels = [];

fs.readFile(filePath, 'utf-8', (err, data) => {
  if (err) throw err;

  xml2js.parseString(data, (error, result) => {
	if (error) throw error;

	const labelsArray = result.CustomLabels.labels.map(label => label.fullName[0]);
	const totalLabels = labelsArray.length;

	console.log("\x1b[31m--------------- Search unused label... ---------------");

	const files = [];
	directories.forEach(directory => {
		const directoryFiles = glob.sync(`${directory}/**/*.*`);
		directoryFiles.forEach(file => {
			const content = fs.readFileSync(file, 'utf-8').toLowerCase();
			files.push(content);
		});
	});

	labelsArray.forEach(label => {
	  counter++;
	  const percent = Math.floor((100 * counter) / totalLabels);
	  process.stdout.write(`\x1b[32m\rProcessing labels: [${'.'.repeat(percent)}${' '.repeat(100-percent)}] ${percent}%\x1b[0m`);

	  const labelLower = `label.${label.toLowerCase()}`;
	  const cLower = `c.${label.toLowerCase()}`;

	  let found = files.some(content => content.includes(labelLower) || content.includes(cLower));

		if (!found) {
		unusedLabels.push(label);
	  }
	});

	console.log("\n\x1b[0;31mUnused labels:\x1b[0m");
	unusedLabels.forEach(label => {
	  console.log(label);
	});

	if (unusedLabels.length > 0) {
		const comment = `:warning: :warning: :warning: :warning:\n\n **Unused Labels:**\n\n${unusedLabels.map(label => `- ${label}`).join('\n')}`;
		postComment(process.env.CI_PROJECT_ID, process.env.CI_MERGE_REQUEST_IID, comment, process.env.PRIVATE_TOKEN).catch(errorWhenPostComment => console.error(`Failed to post comment: ${errorWhenPostComment}`));
	}
  });
});

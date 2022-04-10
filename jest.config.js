const { jestConfig } = require('@salesforce/sfdx-lwc-jest/config');

module.exports = {
    ...jestConfig,
    modulePathIgnorePatterns: ['<rootDir>/.localdevserver'],
		testPathIgnorePatterns : [
			"/\\.history/",
			"/node_modules/"
		],
		coveragePathIgnorePatterns: [
			"/\\.history/",
			"/node_modules/"
		]
};

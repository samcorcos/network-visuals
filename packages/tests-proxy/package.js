Package.describe({
	name: "velocity:test-proxy",
	summary: "Dynamically created package to expose test files to mirrors",
	version: "0.0.4",
	debugOnly: true
});

Package.on_use(function (api) {
	api.use("coffeescript", ["client", "server"]);
	api.add_files("tests/mocha/client/client-test.coffee",["client"]);
	api.add_files("tests/mocha/client/map-test.coffee",["client"]);
	api.add_files("tests/mocha/server/server-test.coffee",["server"]);
});
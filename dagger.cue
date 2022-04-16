package todoapp

import (
	"dagger.io/dagger"
	"dagger.io/dagger/core"

	"universe.dagger.io/yarn"
	"universe.dagger.io/netlify"
)

dagger.#Plan & {
	client: {
		filesystem: "./build": write: contents: actions.build.output
		env: {
			NETLIFY_TOKEN: dagger.#Secret
			USER:          string
		}
	}
	actions: {

		_source: core.#Source & {
			path: "."
			exclude: [
				"node_modules",
				"build",
				"*.cue",
				"*.md",
				".git",
			]
		}

		build: yarn.#Build & {
			source: _source.output
		}

		test: yarn.#Script & {
			source: _source.output
			name:   "test"

			// This environment variable disables watch mode
			// in "react-scripts test".
			// We don't set it for all commands, because it causes warnings
			// to be treated as fatal errors.
			// See https://create-react-app.dev/docs/advanced-configuration/
			container: env: CI: "true"
		}

		deploy: netlify.#Deploy & {
			contents: build.output

			// Load Netlify API token from client environment
			token: client.env.NETLIFY_TOKEN
			// By default, deploy to "$USER-todoapp.netlify.app"
			// Override with `dagger do dev deploy --site NAME`
			site: string | *"dagger-todoapp"
		}
	}
}

package todoapp

import (
	"dagger.io/dagger"
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
		build:  #Build
		test:   #Test
		deploy: #Deploy & {
			token: client.env.NETLIFY_TOKEN
			site:  "\(client.env.USER)-dagger-todoapp"
		}
	}
}

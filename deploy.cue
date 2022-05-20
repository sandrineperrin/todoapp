package todoapp

import (
	"universe.dagger.io/netlify"
)

// Deploy todoapp
#Deploy: {
	app: {
		name:  string | *"dagger-todoapp"
		build: #Build
	}

	url: target.netlify.url

	// Deployment target
	target: "netlify": netlify.#Deploy & {
		contents: app.build.output
		site:     app.name
	}
}

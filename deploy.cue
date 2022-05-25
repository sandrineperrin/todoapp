package todoapp

import (
	"universe.dagger.io/netlify"
)

// Deploy todoapp
#Deploy: {
	_build: #Build

	netlify.#Deploy & {
		contents: _build.output
		site:     string | *"dagger-todoapp"
	}
}

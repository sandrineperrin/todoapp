package todoapp

import (
	"dagger.io/dagger/core"
)

// Load the todoapp source code 
#Source: core.#Source & {
	path: "."
	exclude: [
		"node_modules",
		"build",
		"*.cue",
		"*.md",
		".git",
	]
}

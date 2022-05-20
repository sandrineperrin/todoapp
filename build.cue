package todoapp

import (
	"universe.dagger.io/yarn"
)

// Build todoapp
#Build: yarn.#Script & {
	name:    "build"
	source:  _source.output
	_source: #Source
}

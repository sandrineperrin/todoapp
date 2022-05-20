package todoapp

import (
	"universe.dagger.io/yarn"
)

// Test todoapp
#Test: yarn.#Script & {
	name:    "test"
	source:  _source.output
	_source: #Source

	// This environment variable disables watch mode
	// in "react-scripts test".
	// We don't set it for all commands, because it causes warnings
	// to be treated as fatal errors.
	// See https://create-react-app.dev/docs/advanced-configuration/
	container: env: CI: "true"
}

[
	import_deps: [:ecto_sql],
	plugins: [ Phoenix.LiveView.HTMLFormatter],
	inputs: ["*.{heex,ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
]

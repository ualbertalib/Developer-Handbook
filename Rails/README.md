Rails Resources
---------------
* [Getting Started](http://guides.rubyonrails.org/getting_started.html)
* [Gem writing guidelines](http://guides.rubygems.org/make-your-own-gem/)
* [Rails Engines](http://guides.rubyonrails.org/engines.html)
* [Rails Command Line](http://guides.rubyonrails.org/command_line.html)
* [Rails Configuration](http://guides.rubyonrails.org/configuring.html)
* [ActiveRecord Validations](http://guides.rubyonrails.org/active_record_validations.html)
* [Routing](http://guides.rubyonrails.org/routing.html)
* [Michael Hartl's Rails Tutorial](https://www.railstutorial.org/book)
* [Rails 4 Way](http://proquest.safaribooksonline.com/book/programming/ruby/9780133487954/firstchapter#X2ludGVybmFsX0h0bWxWaWV3P3htbGlkPTk3ODAxMzM0ODc5NTQlMkZwcmVmMDZfaHRtbCZxdWVyeT1CT09L)

Debugging Rails
---------------

Consider ['pry'](http://pryrepl.org/).  Pry is a powerful alternative to the standard IRB shell for Ruby. It features syntax highlighting, a flexible plugin architecture, runtime invocation and source and documentation browsing.

Add to your Gemfile
```
group :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
end
```
and to your config/environments/development.rb
```
silence_warnings do
  require 'pry'
  IRB = Pry
end
```
Then you can run pry in place of IRB by typing 'rails console' on the command line.

```
rails c
Loading development environment (Rails 4.0.4)
[1] pry(main)> help
Help
  help               Show a list of commands or information about a specific command.

Context
  cd                 Move into a new context (object or scope).
  find-method        Recursively search for a method within a class/module or the current namespace.
  ls                 Show the list of vars and methods in the current scope.
  pry-backtrace      Show the backtrace for the pry session.
  raise-up           Raise an exception out of the current pry instance.
  reset              Reset the repl to a clean state.
  watch              Watch the value of an expression and print a notification whenever it changes.
  whereami           Show code surrounding the current context.
  wtf?               Show the backtrace of the most recent exception.

Editing
  /^\s*!\s*$/        Clear the input buffer.
  amend-line         Amend a line of input in multi-line mode.
  edit               Invoke the default editor on a file.
  hist               Show and replay readline history.
  play               Playback a string variable, method, line, or file as input.
  show-input         Show the contents of the input buffer for the current multi-line expression.

Introspection
  ri                 View ri documentation.
  show-doc           Show the documentation for a method or class.
  show-source        Show the source for a method or class.
  stat               View method information and set _file_ and _dir_ locals.

Gems
  gem-cd             Change working directory to specified gem's directory.
  gem-install        Install a gem and refresh the gem cache.
  gem-list           List and search installed gems.
  gem-open           Opens the working directory of the gem in your editor.

Commands
  import-set         Import a pry command set.
  install-command    Install a disabled command.

Aliases
  !!!                Alias for `exit-program`
  !!@                Alias for `exit-all`
  $                  Alias for `show-source`
  ?                  Alias for `show-doc`
  @                  Alias for `whereami`
  clipit             Alias for `gist --clip`
  file-mode          Alias for `shell-mode`
  history            Alias for `hist`
  quit               Alias for `exit`
  quit-program       Alias for `exit-program`
  reload-method      Alias for `reload-code`
  show-method        Alias for `show-source`

Input and output
  .<shell command>   All text following a '.' is forwarded to the shell.
  cat                Show code from a file, pry's input buffer, or the last exception.
  change-inspector   Change the current inspector proc.
  change-prompt      Change the current prompt.
  fix-indent         Correct the indentation for contents of the input buffer
  list-inspectors    List the inspector procs available for use.
  list-prompts       List the prompts available for use.
  save-file          Export to a file using content from the repl.
  shell-mode         Toggle shell mode. bring in pwd prompt and file completion.

Misc
  gist               Upload code, docs, history to https://gist.github.com/.
  pry-version        Show pry version.
```

* [pry](http://pryrepl.org/)
* [RailsCast](http://railscasts.com/episodes/280-pry-with-rails)
* [pry-ecosystem](http://banisterfiend.wordpress.com/2012/02/14/the-pry-ecosystem/)

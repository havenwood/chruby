function chruby-exec()
{
	case "$1" in
		-h|--help)
			echo "usage: chruby-exec RUBY [RUBYOPTS] -- COMMAND"
			exit
			;;
		-V|--version)
			echo "chruby version $CHRUBY_VERSION"
			exit
			;;
		*)
			if [[ $# -eq 0 ]]; then
				echo "chruby-exec: RUBY and COMMAND required" >&2
				exit 1
			fi

			argv=()

			for arg in $@; do
				shift

				if [[ "$arg" == "--" ]]; then break
				else                          argv+=($arg)
				fi
			done

			if [[ $# -eq 0 ]]; then
				echo "chruby-exec: COMMAND required" >&2
				exit 1
			fi

			exec $SHELL -i -l -c "chruby $argv && $*"
			;;
	esac
}

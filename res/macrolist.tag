<macrolist>
	
	<macro each={ macro in macros } macro={ macro } addon={ addon }></macro>
	<button ref="addmacro"></button>
	<button ref="savemacros"></button>

	<script>
		export default {
			onBeforeMount() {
				this.macros = []
				this.addon = this.props.addon
				this.makeAccessible()
			},

			onMounted() {
				this.refs = {
					addmacro: this.$('[ref=addmacro]'),
					savemacros: this.$('[ref=savemacros]')
				}
				this.refs.addmacro.innerHTML = this.addon.i18n.__('Add macro')
				this.refs.savemacros.innerHTML = this.addon.i18n.__('Save settings')

				this.refs.addmacro.onclick = this.addmacro
				this.refs.savemacros.onclick = this.savemacros

				this.reloadsettings()
			},

			addmacro() {
				this.macros.push({'macro': '', 'replace': ''})
				this.update()
			},

			savemacros() {
				this.addon.saveMacros()
			},

			reloadsettings() {
				this.macros = []
				this.update()
				this.macros = this.addon.settings
				this.update()
			}
		}
	</script>
</macrolist>
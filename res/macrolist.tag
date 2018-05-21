<macrolist>
	
	<macro each={ macro in macros } no-reorder macro={ macro }></macro>
	<button ref="addmacro"></button>
	<button ref="savemacros"></button>

	<script>
		const self = this
		this.macros = []
		this.addon = null

		this.on('mount', () => {
			self.addon = Tool.addons.getAddon('macro')
			self.refs.addmacro.innerHTML = self.addon.i18n.__('Add macro')
			self.refs.savemacros.innerHTML = self.addon.i18n.__('Save settings')

			self.refs.addmacro.onclick = self.addmacro
			self.refs.savemacros.onclick = self.savemacros

			self.reloadsettings()
		})

		addmacro() {
			self.macros.push({'macro': '', 'replace': ''})
			self.update()
		}

		savemacros() {
			self.addon.saveMacros()
		}

		reloadsettings() {
			self.macros = self.addon.settings
			self.update()
		}
	</script>
</macrolist>
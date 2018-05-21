<macro>
	<fieldset>
		<label>
			<span ref="lang_macro"></span>
			<input type="text" ref="macro" value="{ macro }" class="macro">
			<small ref="lang_macro_desc"></small>
		</label>
		<label>
			<span ref="lang_replace"></span>
			<input type="text" ref="replace" value="{ replace }" class="replace">
		</label>
	</fieldset>

	<script>
		const self = this
		this.addon = null

		console.log(this.opts.macro)
		this.macro = this.opts.macro.macro
		this.replace = this.opts.macro.replace

		this.on('mount', () => {
			self.addon = Tool.addons.getAddon('macro')
			self.refs.lang_macro.innerText = self.addon.i18n.__('Macro:')
			self.refs.lang_replace.innerText = self.addon.i18n.__('Replacement:')
			self.refs.lang_macro_desc.innerText = self.addon.i18n.__('Is always prepended by a tilde (~) character and can only contain letters and numbers')

			self.refs.macro.onkeyup = () => {
				if(!self.refs.macro.value.startsWith('~')) {
					self.refs.macro.value = '~' + self.refs.macro.value
				}
				let m = self.refs.macro.value.substr(1)
				if(m != m.replace(/[^a-z0-9]/ig, '')) {
					self.refs.macro.value = '~' + m.replace(/[^a-z0-9]/ig, '')
				}
			}

			self.update()
		})
		this.on('update', () => {
			self.macro = self.opts.macro.macro
			self.replace = self.opts.macro.replace
		})
	</script>
</macro>
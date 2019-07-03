<macro>
	<fieldset>
		<label>
			<span ref="lang_macro"></span>
			<input type="text" ref="macro" value={ macro } class="macro">
			<small ref="lang_macro_desc"></small>
		</label>
		<label>
			<span ref="lang_replace"></span>
			<input type="text" ref="replace" value={ replace } class="replace">
		</label>
	</fieldset>

	<script>
		export default {
			onBeforeMount() {
				this.addon = this.props.addon
				this.macro = this.props.macro.macro
				this.replace = this.props.macro.replace
			},

			onMounted() {
				this.refs = {
					lang_macro: this.$('[ref=lang_macro]'),
					macro: this.$('[ref=macro]'),
					lang_macro_desc: this.$('[ref=lang_macro_desc]'),
					lang_replace: this.$('[ref=lang_replace]'),
					replace: this.$('[ref=replace]')
				}

				this.refs.lang_macro.innerText = this.addon.i18n.__('Macro:')
				this.refs.lang_replace.innerText = this.addon.i18n.__('Replacement:')
				this.refs.lang_macro_desc.innerText = this.addon.i18n.__('Is always prepended by a tilde (~) character and can only contain letters and numbers')

				const self = this
				this.refs.macro.onkeyup = () => {
					if(!self.refs.macro.value.startsWith('~')) {
						self.refs.macro.value = '~' + self.refs.macro.value
					}
					let m = self.refs.macro.value.substr(1)
					if(m != m.replace(/[^a-z0-9]/ig, '')) {
						self.refs.macro.value = '~' + m.replace(/[^a-z0-9]/ig, '')
					}
				}
			},
			onBeforeUpdate() {
				this.macro = this.props.macro.macro
				this.replace = this.props.macro.replace
			}
		}
	</script>
</macro>
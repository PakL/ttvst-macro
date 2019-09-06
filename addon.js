
const UIPage  = require(path.dirname(module.parent.filename) + '/../mod/uipage')

class Macro extends UIPage {

	constructor(tool, i18n) {
		super('Macro')

		this.tool = tool
		this.i18n = i18n

		this.contentElement = document.createElement('div')
		this.contentElement.style.padding = '10px'
		this.settings = tool.settings.getJSON('macros', [])

		let macrosTag = fs.readFileSync(__dirname.replace(/\\/g, '/') + '/res/macro.tag', { encoding: 'utf8' })
		let code = riot.compileFromString(macrosTag).code
		riot.inject(code, 'macro', document.location.href)

		let macroslistTag = fs.readFileSync(__dirname.replace(/\\/g, '/') + '/res/macrolist.tag', { encoding: 'utf8' })
		code = riot.compileFromString(macroslistTag).code
		riot.inject(code, 'macrolist', document.location.href)


		let macrolist = document.createElement('macrolist')

		this.contentElement.appendChild(macrolist)
		document.querySelector('#contents').appendChild(this.contentElement)

		riot.mount(macrolist, { addon: this })

		let cockpit = this.tool.cockpit;
		if(cockpit != null) {
			let chatmessage = document.querySelector('#chat_message')
			const self = this
			chatmessage.addEventListener('keyup', () => {
				let newMessage = chatmessage.value
				self.settings.forEach((m) => {
					let rx = new RegExp('(\\s|^)(' + m.macro + ')($|\\s)', 'g')
					newMessage = newMessage.replace(rx, '$1' + m.replace + '$3')
				})
				if(newMessage != chatmessage.value) {
					chatmessage.value = newMessage
				}
			})
		}
	}

	get icon() {
		return 'ProcessMetaTask'
	}

	saveMacros() {
		let macros = this.contentElement.querySelectorAll('macro')
		let macrosSettings = []
		for(let i = 0; i < macros.length; i++) {
			let str_macro = macros[i].querySelector('.macro').value
			let str_replace = macros[i].querySelector('.replace').value

			if(str_macro.length > 0 && str_replace.length > 0) {
				macrosSettings.push({macro: str_macro, replace: str_replace})
			}
		}

		this.lastactiveknown = -1
		this.settings = macrosSettings
		this.tool.settings.setJSON('macros', this.settings)
		this.contentElement.querySelector('macrolist')._tag.reloadsettings()
	}

	open() {
		this.contentElement.style.display = 'block'
	}

	close() {
		this.contentElement.style.display = 'none'
	}

}
module.exports = Macro
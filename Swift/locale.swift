import Foundation

let zhCN = Locale(identifier: "zh-CN")
if let script = zhCN.language.script {
    let enUS = Locale(identifier: "en-US")
    let localizedScript = enUS.localizedString(forScript: script) // "Simplified Han"
}

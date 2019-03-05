import Foundation
import Rainbow





let launchpath = FileManager.default.currentDirectoryPath
//print("======================================================")
//print("FX: script launch from \(launchpath)".yellow.underline)
//print("======================================================")
//
//
//let cmd = FXCommandLine()
//cmd.addOptions(os: [gitStatusOption,gitBranchOption,gitOpenOption])
//cmd.parseAll(args: CommandLine.arguments)
//
//exit(EX_OK)




import SwiftCLI

class GreetCommand: Command {
    let name = "greet"
    let person = Parameter()
    func execute() throws {
        stdout <<< "Hello \(person.value.yellow)!"
    }
}

let greeter = CLI(name: "greeter")
greeter.commands = [GreetCommand()]
_ = greeter.go()

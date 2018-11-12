import Foundation
import Rainbow





let launchpath = FileManager.default.currentDirectoryPath
print("===================================================================")
print("FX: script launch from \(launchpath)".yellow.underline)
print("===================================================================")


let cmd = FXCommandLine()
cmd.addOptions(os: [gitStatusOption,gitBranchOption,gitOpenOption])
cmd.parseAll(args: CommandLine.arguments)

exit(EX_OK)




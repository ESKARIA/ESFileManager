# ESFileManager

A simple library for use iOS File manager

# Usage

## Standart use

1) Import in project

```swift
import ESFileManager
```

[model of log](https://eskaria.github.io/AdvancedLogger/Structs.html#/s:14AdvancedLogger0aB5ModelV) 

2) Create property of ESFileManager. In argument used default way for write/read data, but you can use init with default value "Document folder without iCloud sync". You can read about [this folders and when use kind of this](https://eskaria.github.io/ESFileManager/Enums/ESFileExtensionType.html)

```swift
private var fileManager: ESFileManagerProtocol = ESFileManager()
```

3) You can read data with [read func](https://eskaria.github.io/ESFileManager/Protocols/ESFileManagerProtocol.html#/s:13ESFileManager0aB8ProtocolP4read11fileStorage2at10completionyAA0A9NameModelV_AA0aB9DirectoryOSgyAA0aJ0VSg_s5Error_pSgtcSgtF). For read and write used [model of file](https://eskaria.github.io/ESFileManager/Structs/ESFileModel.html) which contain [model with name and extension of file](https://eskaria.github.io/ESFileManager/Structs/ESFileNameModel.html)


```swift
private func readFile() {
    // create name and extension of file to read
    let file = ESFileNameModel(name: "SwiftDoc", fileExtension: .txt)
    
    //read this file. At = nil cause we use default directory
    fileManager.read(fileStorage: file, at: nil) { (file, error) in
        //fetch error
        if let error = error {
            //fetch error
            return
        }
        //fetch empty state of file
        guard let data = file?.data else {
            // file is empty!
            return
        }
        //show our file
        let stringFile = String(data: data, encoding: .utf8)
        //You successful read the file!
    }
}
```

3) You can write your file on disk with [write func](https://eskaria.github.io/ESFileManager/Protocols/ESFileManagerProtocol.html#/s:13ESFileManager0aB8ProtocolP5write4file2at10completionyAA0A5ModelV_AA0aB9DirectoryOSgys5Error_pSgcSgtF)

```swift
private func writeFile() {
    // create data to write
    let data = "Swift is amazing!".data(using: .utf8)
    
    let fileName = ESFileNameModel(name: "SwiftDoc", fileExtension: .txt)
    let file = ESFileModel(data: data, name: fileName)
    
    // write data. At = nil cause we use default directory from prepareVC method
    fileManager.write(file: file, at: nil) { (error) in
        if let error = error {
            //error
            return
        }
        //You successful recorded the file!
    }
}
```

4) For remove file you [remove func](https://eskaria.github.io/ESFileManager/Protocols/ESFileManagerProtocol.html#/s:13ESFileManager0aB8ProtocolP6remove4file2at10completionyAA0A9NameModelV_AA0aB9DirectoryOSgys5Error_pSgcSgtF)

```swift
private func removeFile() {
    // create name and extension of file to remove
    let file = ESFileNameModel(name: "SwiftDoc", fileExtension: .txt)
    
    //remove this file. At = nil cause we use default directory
    fileManager.remove(file: file, at: nil) { (error) in
        //fetch error
        if let error = error {
            // fetch error
            return
        }
        //You successful remove this file!
    }
}
```

5) You can geet list of files in your directory with [list func](https://eskaria.github.io/ESFileManager/Protocols/ESFileManagerProtocol.html#/s:13ESFileManager0aB8ProtocolP9listFiles2at10completionyAA0aB9DirectoryOSg_ySayAA0A9NameModelVGSg_s5Error_pSgtcSgtF)

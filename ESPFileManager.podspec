Pod::Spec.new do |s|
    
    # 1
    s.platforms = { :ios => "11.0", :osx => "10.14", :watchos => "5.0", :tvos => "10.0" }
    s.name = "ESPFileManager"
    s.summary = "ESFileManager swift 5.1 framework for advanced write and read file from your local iOS storage."
    s.requires_arc = true
    
    # 2
    s.version = "0.0.5"
    
    # 3
    s.license = { :type => "MIT", :file => "LICENSE" }
    
    # 4 - Replace with your name and e-mail address
    s.author = { "Dmitriy Toropkin" => "toropkind@gmail.com" }
    
    # 5 - Replace this URL with your own Github page's URL (from the address bar)
    s.homepage = "https://github.com/ESKARIA/ESFileManager.git"
    
    # 6 - Replace this URL with your own Git URL from "Quick Setup"
    s.source = { :git => "https://github.com/ESKARIA/ESFileManager.git", :tag => "#{s.version}"}
    
    # 7
    s.framework = "Foundation"
    
    # 8
    s.source_files = "ESFileManager/**/*.{swift}"
    s.exclude_files = 'ESFileManager/ESFileManagerExample_iOS/', 'ESFileManagerExample_iOS/', 'ESFileManager/ESFileManagerTests', 'ESFileManagerTests'
    
end

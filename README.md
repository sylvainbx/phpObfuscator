# phpObfuscator
a simple and powerfull php code obfuscator

## Project status
This obfuscator was written by me in 2012 and used in production for years. It was not updated since but I publish it here hoping it can be usefull for someone. There's  however some limitations :
- Inline comments starting by `#` are not supported
- I have no ideas if this works on files containing PHP code version > 6
- There's a module called Obfuscator.pm that is not used in the code because I never had time to debug it to the end. Feel free to improve it to make it work. If you do, please share your result with the community.
- Despite the lack of the Obfuscator module, the program does the job enough to our eyes.

## Usage

```bash
chmod u+x main.pl
./main.pl <php_code_folder> <...>
```

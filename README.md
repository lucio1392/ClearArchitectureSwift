# **Create documentation using Jazzy 📃📃**

#### Table content:
  1. [Install `Jazzy`.](#Install`Jazzy`)
  2. [Configuration using `.jazzy.yaml` file.](#configuration)
  3. [Document your `source code`.](#documentsourcecode)
  4. [Upload to `host`.](#upload)

  ---------------------------------------

#### 1. Install `Jazzy`<a name="Install`Jazzy`"></a>

  * Open terminal and run `[sudo] gem install jazzy`.

        If your got any problems during install Jazzy please refer by the link below:
        https://github.com/realm/jazzy#installation-problems

  * After finish above step please go to your root project directory and then run: `jazzy` without any arguments for start creating your document.

  ( You can try to verify `xcodebuild` first, if everything going well then your `jazzy` command should succeed too )

  * `Jazzy` will start building and give you the following report like the image below (If everything succeed):
<!-- Import image here -->

  * `Jazzy` will create the `docs` folder by default. It's contains all the source to create our document. You can try to run the `index.html` to get the result.
<!-- Import image here -->

  * You can config your `jazzy` build options in configuration file `.jazzy.yaml` ( We take this step in next section ). All config options available and can check by following command `jazzy --help config`

#### 2. Configuration using `.jazzy.yaml` file. <a name="configuration"></a>

  `Jazzy` support us with many of configuration options to build our document. Below is some simple and common options that we will use to config and customize our document:

  * Create `.jazzy.yaml` in your root project directory

  * Put the config content below into `.jazzy.yaml` you just created.

  ```yaml
  clean: true #Clean everything before generate new docs

  module: PhotoSDK #Project module name. You can find this module name from your project's Building Setting at Product Module Name field.

  theme: fullwidth #Choose your theme. Jazzy support 3 default theme following Apple, Fullwidth, Jony

  skip_undocumented: false #Skip everything in your source code that not documented yet

  readme: README.md #README file name

  output: docs/SaleSDKInterfaceDocument #Where you want to put your document

  min_acl: public #Access Control level to document (private/ fileprivate/ internal/ public)

  documentation: Documentation/*.md #The folder to get your markdown's documents

  undocumented_text: Document for this field will be update soon 😍😍😍 #Custom undocumented description text

  hide_documentation_coverage: false

  sdk: iphone #The SDK you should use for building your document (iphone,watch,appletv)
  xcodebuild_arguments: #Support build with xcodebuild, so you can modify your xcodebuild's arguments
    - -workspace
    - Github Repository.xcworkspace
    - -scheme
    - Github Repository
  author: Est Rouge Mobile Team
  author_url: https://est-rouge.com/
  custom_categories: #Custom category help you to arrange and replace the default order from Jazzy.
    - name: Gettings Started
      children:
        - Gettings Started
    - name: Domain Provider
      children:
        - UseCasesProviderPlatform
    - name: Domain Usecases
      children:
        - AuthenticationUseCase
        - PhotoUseCase
        - UseCasesProvider
    - name: Domain Models
      children:
        - AccessToken
        - Photo
        - PhotoAttribute
        - PhotoSource
        - PhotosError
        - User
        - UserProfileSource
    - name: Common Extensions
      children:
        - KingfisherManager
        - ObservableType
        - Reactive
```

For more config options and their use please run `jazzy --help config` command.

Beside config with `jazzy.yaml` you can attach the arguments when running `jazzy` command. ex: `jazzy --theme=jony`.

You can also create some `Makefile` to help your life more easier.
ex:

```makefile
documentation:
	@jazzy \
				--clean [yes] \
				--copyright 'Copyright - EstRouge Mobile Team' \
        --min-acl public \
        --no-hide-documentation-coverage \
        --theme fullwidth \
        --output ./docs/public_api_document \
				--documentation=./*.md \
				--module 'PhotoSDK' \
				--author 'EstRouge Mobile Team'
				@rm -rf ./build


documentationSdk:
					@jazzy \
				        --min-acl internal \
				        --no-hide-documentation-coverage \
				        --theme fullwidth \
				        --output ./docs/sdk_document \
				      	--documentation=./*.md
								@rm -rf ./build
```

#### 3. Document your `source code`.<a name="documentsourcecode"></a>

* As we know that `XCode` support for `Markup` that including `Markdown` for documentation our source. `Jazzy` support to generate everything that we comment and document in our codebase.

Please take a look at example below:

```swift
/// Authentication flow Interface.
///
/// This interface describe the full flow follwing OAUTH 2.0 protocol to get a User's AccessToken
public protocol AuthenticationUseCase {

    /// The Url request to redirect to login page for authentication
    var oauthRedirect: Observable<URLRequest> { get }

    /// Return an Access Token after request
    ///
    /// - Parameter code: The Code returned from **Open Authen** process
    /// - Returns: Return an Access Token after request
    func accessToken(code: String) -> Observable<AccessToken>


    /// Detect the authen code after **Login Process**
    ///
    /// - Parameters:
    ///   - param: Param want to get the value
    ///   - resultUrl: the redirect URI return from result
    /// - Returns: Value Code for get **Access Token**
    func openAuthen(param: String, resultUrl: URL) -> Observable<String>
}

```
* `Jazzy` will generate everything like below (depend on your template):
<!-- Import image here -->

* Please refer following docs to learn how to document your source code using `Markup` and `Markdown`:

  * https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/

  * https://books.apple.com/us/book/swift-documentation-markup/id1049010423

#### 4. Upload to `host`.<a name="upload"></a>

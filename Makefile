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

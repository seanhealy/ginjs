PACKAGE      = ginjs
VERSION      = ` date "+%Y.%m.%d" `
RELEASE_DIR  = bin
RELEASE_FILE = $(PACKAGE)-$(VERSION)

# Notice that the variable LOGNAME comes from the environment in
# POSIX shells.
#
# target: all - Default target. Does nothing.
all:
	@echo "Building a combined file..."
	@if [ ! -d $(RELEASE_DIR) ]; then mkdir $(RELEASE_DIR); fi
	@cat src/* > $(RELEASE_DIR)/$(RELEASE_FILE).coffee
	
	@echo "Compiling Coffee..."
	@coffee -c $(RELEASE_DIR)/$(RELEASE_FILE).coffee
	
	@echo "Copying Newest Build to $(RELEASE_DIR)/gin.js..."
	@if [ -f $(RELEASE_DIR)/gin.js ]; then rm $(RELEASE_DIR)/gin.js; fi
	@cd $(RELEASE_DIR); \
	cp $(RELEASE_FILE).js gin.js
	
	@echo "Great Success!"

routes:
	@echo "Building a combined file..."
	@if [ ! -d $(RELEASE_DIR) ]; then mkdir $(RELEASE_DIR); fi
	@cat src/_init.coffee src/Route.coffee src/RouteManager.coffee > $(RELEASE_DIR)/routes.coffee
	
	@echo "Compiling Coffee..."
	@coffee -c $(RELEASE_DIR)/routes.coffee

# target: help - Display callable targets.
help:
	egrep "^# target:" [Mm]akefile

clean:
	rm $(RELEASE_DIR)/*
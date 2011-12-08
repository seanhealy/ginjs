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
	
	@echo "Great Success!"

# target: help - Display callable targets.
help:
	egrep "^# target:" [Mm]akefile

clean:
	rm $(RELEASE_DIR)/*
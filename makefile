LANG_NAME='ruby'
FILE_BISON='$(LANG_NAME).y'
FILE_BISON_LOG='$(LANG_NAME).bison.log'
FILE_BISON_GRAPH='$(LANG_NAME).bison.graph'
FILE_BISON_OUTPUT='$(LANG_NAME)'
FILE_BISON_DEFINES='$(LANG_NAME).bison.defines.h'
BISON='bison'
RUN_BISON='$(BISON) --report-file=$(FILE_BISON_LOG) -v --graph=$(FILE_BISON_GRAPH)'

default: $(FILE_BISON)
  
$(FILE_BISON):
	$(BISON) --report-file=$(FILE_BISON_LOG) --graph=$(FILE_BISON_GRAPH) -v --defines=$(FILE_BISON_DEFINES) $(FILE_BISON)


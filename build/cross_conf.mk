ifeq ($(arch),rp4)
-include $(ERVS_DIR)cross_conf_rp4.mk
else 
-include $(ERVS_DIR)cross_conf_pc.mk
endif

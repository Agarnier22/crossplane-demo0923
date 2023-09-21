.DEFAULT_GOAL := help
.PHONY: help

help: ## Show help for all targets
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

startaws: ## Claims networks and clusters on AWS
	@echo "Claim of AWS resources..."
	@for i in $$(find demo/AWS/Demo/* -name "*.yaml" -type f | grep -vE "config|provider"); do kubectl apply -f $$i;done
	@echo "Ressources successfully claimed!"
	@echo ""
.PHONY:startaws

startazure: ## Claims networks and clusters on AZURE
	@echo "Claim of Azure resources..."
	@for i in $$(find demo/Azure/Demo/* -name "*.yaml" -type f | grep -vE "config|provider"); do kubectl apply -f $$i;done
	@echo "Ressources successfully claimed!"
	@echo ""
.PHONY:startazure

startgcp: ## Claims networks and clusters on GCP
	@echo "Claim of GCP  resources..."
	@for i in $$(find demo/GCP/Demo/* -name "*.yaml" -type f | grep -vE "config|provider"); do kubectl apply -f $$i;done
	@echo "Ressources successfully claimed!"
	@echo ""
.PHONY:startgcp

startdemo: start startaws startazure startgcp end ## Claims networks and clusters on AWS, GCP and Azure
.PHONY:startdemo

start:
	@echo "Starting Demo..."
	@echo ""
.PHONY:start

end:
	@echo "Demo successfully started!"
.PHONY:end

awsnuke: ##Claim deletion of AWS resources
	@echo "Deletion of AWS resources..."
	@kubectl get managed -l provider=AWS | awk '$$0 !~/NAME/ {print $$1}' | xargs kubectl delete
	@echo "Ressources successfully deleted!"
	@echo ""
.PHONY:awsnuke

azurenuke: ##Claim deletion of Azure resources
	@echo "Deletion of Azure resources..."
	@kubectl get managed -l provider=Azure | awk '$$0 !~/NAME/ {print $$1}' | xargs kubectl delete
	@echo "Ressources successfully deleted!"
	@echo ""
.PHONY:azurenuke

gcpnuke: ##Claim deletion of GCP resources
	@echo "Deletion of GCP resources..."
	@kubectl get managed -l provider=GCP | awk '$$0 !~/NAME/ {print $$1}' | xargs kubectl delete
	@echo "Ressources successfully deleted!"
	@echo ""
.PHONY:gcpnuke

managednuke: ## Delete all crossplane managed resources on cluster
	@echo "Claim deletion..."
	@kubectl get managed | awk '$$0 !~/NAME/ {print $$1}' | xargs kubectl delete
	@echo "Resources successfully deleted!"
.PHONY:managednuke
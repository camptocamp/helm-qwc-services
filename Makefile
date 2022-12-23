HELM ?= helm

gen-expected:
	${HELM} template --namespace=default test . > tests/expected.yaml || \
		${HELM} template --debug --namespace=default test .
	sed -i 's/[[:blank:]]\+$$//g'  tests/expected.yaml

#start-local:
#	k3d cluster delete test-cluster || true
#	k3d cluster create test-cluster --no-lb --no-hostip --no-rollback --k3s-server-arg --no-deploy=traefik,servicelb,metrics-server
#	${HELM} install test-pg --set=persistence.enabled=false --set=tls.enabled=true --set=tls.autoGenerated=true --set=postgresqlPassword=mySuperTestingPassword --set=volumePermissions.enabled=true bitnami/postgresql
#	c2cciutils-k8s-wait
#	${HELM} install test-redis --set=auth.enabled=false --set=replica.replicaCount=0 --set=master.persistence.enabled=false bitnami/redis
#	kubectl run test-pg-postgresql-client --restart=Never --namespace=default --image=docker.io/bitnami/postgresql:11.13.0-debian-10-r60 --env=PGPASSWORD=mySuperTestingPassword --stdin=true --command -- psql --host=test-pg-postgresql --username=postgres --dbname=postgres --port=5432 < tests/db.sql
#	kubectl apply -f tests/recommend-expected.yaml

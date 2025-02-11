source ${CICD_ROOT}/_common_deploy_logic.sh

# Deploy k8s resources for app and its dependencies (use insights-stage instead of insights-production for now)
# -> use this PR as the template ref when downloading configurations for this component
# -> use this PR's newly built image in the deployed configurations
export NAMESPACE=$(bonfire namespace reserve --pool real-managed-kafka)

bonfire deploy \
    --pool real-managed-kafka \
    ${APP_NAME} \
    --source=appsre \
    --set-template-ref ${APP_NAME}/${COMPONENT_NAME}=${GIT_COMMIT} \
    --set-image-tag ${IMAGE}=${IMAGE_TAG} \
    --namespace ${NAMESPACE} \
    --timeout 600 \
    --no-remove-resources drift \
    --no-remove-resources system-baseline \
    --no-remove-resources historical-system-profiles \
    ${COMPONENTS_ARG} \
    ${COMPONENTS_RESOURCES_ARG}

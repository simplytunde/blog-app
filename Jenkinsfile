podTemplate(label: 'docker',
  containers: [
      containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
      containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.0', command: 'cat', ttyEnabled: true),
      containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:latest', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')
  ]) {

  def image = "jenkins/jnlp-slave"
  node('docker') {
   stage('Upgrade Deployment') {
      git 'https://github.com/simplytunde/tutorial.git'
      if (env.BRANCH_NAME == 'master') {
         container('helm') {
             sh "helm upgrade --recreate-pods blogapp-prod --set branch=master --set site=prod demo/helm/charts/blogapp/ --namespace prod"
         }
      }else{
        if (env.BRANCH_NAME == 'staging') {
           container('helm') {
              sh "helm del --purge blogapp-staging"
              sh "helm install --name blogapp-staging --set branch=staging --set site=staging demo/helm/charts/blogapp/ --namespace staging"
           }
        }else{
           container('helm') {
               sh "helm del --purge blogapp-dev"
               sh "helm install --name blogapp-dev --set branch=dev --set site=dev demo/helm/charts/blogapp/ --namespace dev"
           }
        }
      }
    }

  }
}

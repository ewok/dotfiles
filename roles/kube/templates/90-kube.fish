function __kubectl_abbr_init

    if test "$__kubectl_abbr_inited" = 1
      return
    end

    set -g __kubectl_abbr_inited 1

    abbr -a k kubectl
    abbr -a kx kubectx
    abbr -a kens kubens

    abbr -a kg  'kubectl get'
    abbr -a kga 'kubectl get all'
    abbr -a kgn 'kubectl get nodes'
    abbr -a kgS 'kubectl get services'
    abbr -a kgp 'kubectl get pods'
    abbr -a kgc 'kubectl get configmaps'
    abbr -a kgs 'kubectl get secrets'
    abbr -a kgd 'kubectl get deployments'
    abbr -a kgr 'kubectl get replicasets'
    abbr -a kgi 'kubectl get ingress'
    abbr -a kgv 'kubectl get volumes'

    abbr -a kd  'kubectl describe'
    abbr -a kdp 'kubectl describe pods'
    abbr -a kdS 'kubectl describe services'
    abbr -a kdn 'kubectl describe nodes'
    abbr -a kdc 'kubectl describe configmaps'
    abbr -a kds 'kubectl describe secrets'
    abbr -a kdd 'kubectl describe deployments'
    abbr -a kdr 'kubectl describe replicasets'
    abbr -a kdi 'kubectl describe ingress'
    abbr -a kdv 'kubectl describe volumes'

    abbr -a ke  'kubectl edit'
    abbr -a kep 'kubectl edit pods'
    abbr -a keS 'kubectl edit services'
    abbr -a ken 'kubectl edit nodes'
    abbr -a kec 'kubectl edit configmaps'
    abbr -a kes 'kubectl edit secrets'
    abbr -a ked 'kubectl edit deployments'
    abbr -a ker 'kubectl edit replicasets'
    abbr -a kei 'kubectl edit ingress'
    abbr -a kev 'kubectl edit volumes'

    abbr -a kX 'kubectl delete'
    abbr -a kXp 'kubectl delete pods'
    abbr -a kXS 'kubectl delete services'
    abbr -a kXc 'kubectl delete configmaps'
    abbr -a kXs 'kubectl delete secrets'
    abbr -a kXd 'kubectl delete deployments'

    # kubectl exec
    abbr -a kex 'kubectl exec -it'

    # kubectl logs
    abbr -a kl  'kubectl logs'

    # kubectl port-forward
    abbr -a kpf  'kubectl port-forward'
    abbr -a kpfp 'kubectl port-forward pods'

    # kubectl run
    abbr -a kr  'kubectl run'
    abbr -a krp 'kubectl run pods'

    # kubectl scale
    abbr -a ksc  'kubectl scale'
    abbr -a kscp 'kubectl scale pods'

end

__kubectl_abbr_init

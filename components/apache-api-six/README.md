## Apache api-six
https://apisix.apache.org/zh/blog/2021/12/15/deploy-apisix-in-kubernetes/
### 安装步骤
```shell
kubectl apply -f etcd.yml
kubectl apply -f apisix.yml
kubectl apply -f apisix-dashboard.yml
```
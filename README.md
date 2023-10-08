# Дипломный практикум в Yandex.Cloud

---
## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения

## Этапы выполнения 

### Предварительная подготовка облачной инфраструктуры к установке и запуску Kubernetes кластера.

1. Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя.

![Alt text](image.png)

2. Подготовьте [backend](https://www.terraform.io/docs/language/settings/backends/index.html) для Terraform:  
   Альтернативный вариант: S3 bucket в созданном ЯО аккаунте

```
kunaev@dub-ws-235:~/projects/netology-dev-diplom/tf$ yc storage bucket list
+------------------+----------------------+-------------+-----------------------+---------------------+
|       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
+------------------+----------------------+-------------+-----------------------+---------------------+
| kunaev-diplom-os | b1gumqlak859lpd79r0d | 53687091200 | STANDARD              | 2023-10-08 08:47:46 |
+------------------+----------------------+-------------+-----------------------+---------------------+
```

![Alt text](image-1.png)

3. Настройте [workspaces](https://www.terraform.io/docs/language/state/workspaces.html)  
   а. Рекомендуемый вариант: создайте два workspace: *stage* и *prod*. В случае выбора этого варианта все последующие шаги должны учитывать факт существования нескольких workspace.  

```
kunaev@dub-ws-235:~/projects/netology-dev-diplom/tf$ terraform workspace list
  default
* prod
  stage
```

4. Создайте VPC с подсетями в разных зонах доступности.
5. Убедитесь, что теперь вы можете выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий.
   
![Alt text](image-2.png)


Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий.
2. Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

---

### Запустить и сконфигурировать Kubernetes кластер.


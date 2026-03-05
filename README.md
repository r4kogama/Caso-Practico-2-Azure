# Caso Práctico 2: Automatización de despliegues en entornos Cloud

## Objetivos de la actividad

- Crear infraestructura de forma automatizada en un proveedor de Cloud pública.
- Utilizar herramientas de gestión de la configuración para automatizar la instalación y configuración de servicios.
- Desplegar mediante un enfoque totalmente automatizado aplicaciones en forma de contenedor sobre el sistema operativo.
- Desplegar mediante un enfoque totalmente automatizado aplicaciones que hagan uso de almacenamiento persistente sobre una plataforma de orquestación de contenedores.

---

## Descripción de la actividad

El caso práctico 2 consiste en desplegar los siguientes elementos:

1. **Un (1) repositorio de imágenes de contenedores** sobre infraestructura de Microsoft Azure mediante el servicio Azure Container Registry (ACR).
2. **Una (1) aplicación en forma de contenedor** utilizando Podman sobre una máquina virtual en Azure.
3. **Un (1) cluster de Kubernetes** como servicio gestionado en Microsoft Azure (AKS).
4. **Una (1) aplicación con almacenamiento persistente** sobre el cluster AKS.

---

## Consideraciones

### Generales

- El código desarrollado por el alumno deberá estar disponible en un repositorio git público sin modificaciones posteriores a la fecha de entrega. Si el repositorio no es accesible públicamente no se podrá proceder con la evaluación.
- El código tendrá una estructura específica que será comentada en clase.
- Todo el código desarrollado por el alumno deberá ser original. Cualquier indicio de copia podrá ser motivo de suspenso.
- El código deberá estar comentado (en inglés o español) de forma clara y detallada.
- Toda la infraestructura debe crearse en Azure mediante **Terraform**. No se admite la creación de ningún recurso de forma manual.
- Toda la configuración y el despliegue de las aplicaciones debe hacerse mediante **Ansible**. No se admiten pasos manuales de configuración.
- Siempre que sea posible se deberá evitar la utilización de los siguientes módulos de Ansible:
  - `command`
  - `shell`
  - `script`
- Las aplicaciones desplegadas en Podman y en Kubernetes deben ser **distintas**.

---

### Registry desplegado mediante ACR

- El servicio debe ser accesible desde Internet.
- El acceso debe ser mediante autenticación.
- En este repositorio se deben ubicar las imágenes de las dos aplicaciones a desplegar.
- Cada imagen de contenedor debe encontrarse bajo una **carpeta distinta** del repositorio.
- La versión de las imágenes debe ser `casopractico2`.

---

### Aplicación sobre la máquina virtual

- Debe desplegarse en forma de contenedor de **Podman** sobre una máquina virtual en Azure.
- El sistema operativo debe ser **Linux** (distribución de libre elección: Debian, CentOS, Alma Linux, etc.).
- La aplicación se podrá gestionar como un servicio del sistema operativo, persistente a reinicios, con opción de detener o iniciar por un administrador.
- La imagen de la aplicación se descargará desde el registry ACR.
- La aplicación será un **servidor web** de libre elección (Apache, Nginx, etc.).
- El servicio web debe apoyarse en un **certificado x.509 autofirmado**.
- El servicio web debe utilizar al menos **autenticación básica** (htpasswd).
- El contenido mostrado por el servicio web será de libre elección.
- La aplicación deberá ser **accesible desde Internet**.
- La imagen tendrá todos los datos necesarios: contenido, certificado x.509 y credenciales de usuarios.

---

### Cluster de Kubernetes

- El cluster deberá desplegarse como servicio gestionado en Azure (**AKS**).
- Solo es necesario desplegar un único worker.
- El cluster tendrá conectividad hacia el registry privado de ACR.
- Deberán configurarse las credenciales de acceso al registry para que las aplicaciones puedan autenticarse.

---

### Aplicación sobre Kubernetes

- La aplicación descargará una o más imágenes desde el registry privado. La imagen **no puede ser la misma** que la utilizada en Podman.
- El tipo de aplicación a desplegar es de libre elección (Apache, Nginx, Jenkins, MongoDB, etc.).
- La aplicación debe utilizar **almacenamiento persistente** a partir de alguna de las storage classes definidas en AKS.
- La aplicación debe ser **accesible desde Internet**.
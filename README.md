# Overview
Displays a simple list of events from the selected liferay calendar portlet.

# Dependencies
1. Requires version 6.2.0.13 of the calendar-portlet-service.jar at compile and runtime.
 * Either build the jar from [source](https://github.com/liferay/com-liferay-calendar) or [download](https://web.liferay.com/de/marketplace/-/mp/application/31070085) the calendar portlet and grab it from /WEB-INF/lib/.
 * Either install the jar locally or deploy it to an artifactory of your choice in order to satisfy the maven compile time dependency.
 * Copy the jar to your container's global include path (e.g. /lib/ext/ for tomcat) to make the jar available at runtime.

2. Requires version 1.0.0 of the event-support-library.jar at compile and runtime.
 * Build the jar from [source](https://github.com/jkaref/event-support-library).
 * Either install the jar locally or deploy it to an artifactory of your choice in order to satisfy the maven compile time dependency.
 * Copy the jar to your container's global include path (e.g. /lib/ext/ for tomcat) to make the jar available at runtime.

# Build
First make sure you have setup your settings.xml correctly. The following properties need to be set for the maven-liferay-plugin to run:

```
liferay.install
liferay.tomcat.version
liferay.tomcat.dir
liferay.auto.deploy.dir
liferay.app.server.dir
liferay.app.server.deploy.dir
liferay.app.server.lib.global.dir
liferay.app.server.portal.dir
```

Then package and install:

```
mvn clean package liferay:deploy
```

# Usage
After the porlet has been added to a page for the first time, you will have to select a source calendar from the preferences menu.   

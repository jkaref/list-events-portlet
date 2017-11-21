<%-- 
     Copyright (C) 2017 [j]karef GmbH
     
     Permission is hereby granted, free of charge, to any person obtaining a copy
     of this software and associated documentation files (the "Software"), to deal
     in the Software without restriction, including without limitation the rights
     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     copies of the Software, and to permit persons to whom the Software is
     furnished to do so, subject to the following conditions:
     
     The above copyright notice and this permission notice shall be included in
     all copies or substantial portions of the Software.
     
     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
     SOFTWARE.
--%>
<%@ include file="../../init.jsp" %>

<%
	ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	pageContext.setAttribute("booking", (CalendarBooking)row.getObject());
%>

<c:set var="datePattern" value="d. MMMM yyyy" />
<c:set var="timePattern" value="HH:mm" />

<%-- Harcoded the time zone for now to match the one the calendar portlet is running on --%>
<c:set var="timeZone" value="Europe/London" />

<p class="title">
	<aui:a href="/veranstaltungskalender/-/calendar/event/${event.calendarBookingId}">
		${booking.titleCurrentValue}
	</aui:a>
</p>

<jsp:useBean id="startTime" class="java.util.Date"/>
<jsp:useBean id="endTime" class="java.util.Date"/>

<c:set target="${startTime}" property="time" value="${booking.startTime}"/>
<c:set target="${endTime}" property="time" value="${booking.endTime}"/>

<c:set var="eventDisplay" value="${display:fromEvent(booking)}"/>

<p class="date-and-time">
	<span>
		<c:choose>
			<c:when test="${SINGLE_DAY eq eventDisplay}">
				<fmt:formatDate value="${startTime}" pattern="${datePattern}" timeZone="${timeZone}" />						
			</c:when>

			<c:when test="${MULTI_DAY eq eventDisplay}">
				<fmt:formatDate value="${startTime}" pattern="d." timeZone="${timeZone}" />
				&dash;
				<fmt:formatDate value="${endTime}" pattern="${datePattern}" timeZone="${timeZone}"  />
			</c:when>
			
			<c:when test="${MUTLI_MONTH eq eventDisplay}">
				<fmt:formatDate value="${startTime}" pattern="d. MMMM" timeZone="${timeZone}" />
				&nbsp;&dash;&nbsp;
				<fmt:formatDate value="${endTime}" pattern="${datePattern}" timeZone="${timeZone}" />																									
			</c:when>

			<c:otherwise>
				<%-- skip events we don't know about --%>
			</c:otherwise>
		</c:choose>
	</span>
	&vert;
	<span>
		<c:choose>
			<c:when test="${event.allDay}">
				<liferay-ui:message key="label.span.all-day" />									
			</c:when>
			<c:otherwise>
				<liferay-ui:message key="label.span.begin" />&colon;
				<fmt:formatDate value="${startTime}" pattern="${timePattern}" timeZone="${timeZone}" />						
				<liferay-ui:message key="label.span.time" />
			</c:otherwise>
		</c:choose>
		
		<c:if test="${SINGLE_DAY eq eventDisplay and not event.allDay}">
			&vert;
			<liferay-ui:message key="label.span.end" />&colon;
			<fmt:formatDate value="${endTime}" pattern="${timePattern}" timeZone="${timeZone}" />												
			<liferay-ui:message key="label.span.time" />
		</c:if>																																
	</span> 
</p>
							
<p class="location">${booking.getLocation()}</p>

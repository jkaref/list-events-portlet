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
<%@ include file="../init.jsp" %>

<c:choose>
	<c:when test="${not empty calendarIds}">
		<liferay-ui:search-container 
			emptyResultsMessage="message.warning.no-events-to-display">
		
			<liferay-ui:search-container-results 
				results="${bookings}" 
				total="${bookingsCount}" />
			
			<liferay-ui:search-container-row 
				className="com.liferay.calendar.model.CalendarBooking"
				keyProperty="calendarBookingId" 
				modelVar="booking">
						
				<liferay-ui:search-container-column-jsp 
					path="/html/event-list/search-container/event.jsp" 
					name="events" />	
			
			</liferay-ui:search-container-row>
		
			<liferay-ui:search-iterator />
		
		</liferay-ui:search-container>
	</c:when>
	
	<c:otherwise>
		<div class="alert alert-info">
			<liferay-ui:message key="message.warning.no-calendar-selected" />
		</div>
	</c:otherwise>

</c:choose>

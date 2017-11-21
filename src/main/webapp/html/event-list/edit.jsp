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

<liferay-ui:error key="error-saving-preferences" message="message.error.saving-preferences" />

<liferay-portlet:actionURL name="savePreferences" var="saveURL" />
<liferay-portlet:renderURL var="backURL" portletMode="<%= PortletMode.VIEW.toString() %>"/>

<aui:form action="${saveURL}" method="POST">

	<aui:input name="selectedCalendars" type="hidden" />

	<aui:field-wrapper label="label.select.choose-calendar">
		<liferay-ui:input-move-boxes 
			leftList="${availableCalendars}" rightList="${selectedCalendars}" 
			leftBoxName="available" rightBoxName="selected"
			leftTitle="label.span.available-calendars" rightTitle="label.span.selected-calendars"
		/>
	</aui:field-wrapper>
	
	<aui:button-row>
        <aui:button type="button" value="back" href="${backURL}" />
        <aui:button type="submit" value="save" />
    </aui:button-row>
</aui:form>

<aui:script use="liferay-util-list-fields">
	A.one('#<portlet:namespace/>fm').on('submit', function(event) {
	    var selectedValues = Liferay.Util.listSelect('#<portlet:namespace/>selected');
	    A.one('#<portlet:namespace/>selectedCalendars').val(selectedValues);
    
	    submitForm('#<portlet:namespace/>fm');
	});
</aui:script>

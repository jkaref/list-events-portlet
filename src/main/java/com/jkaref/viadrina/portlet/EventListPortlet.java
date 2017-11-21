/** 
 *  Copyright (C) 2017 [j]karef GmbH
 *  
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *  
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */



package com.jkaref.viadrina.portlet;

import java.io.IOException;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.jkaref.viadrina.portlet.service.ServiceUtil;
import com.jkaref.viadrina.portlet.util.ParamUtil;
import com.liferay.calendar.model.Calendar;
import com.liferay.calendar.model.CalendarBooking;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.util.KeyValuePair;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class EventListPortlet extends MVCPortlet {

	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		List<Long> calendarIds = ParamUtil.getCalendarIds(renderRequest);

		int current = ParamUtil.getCurrent(renderRequest);
		int delta = ParamUtil.getDelta(renderRequest);

		List<CalendarBooking> bookings = ServiceUtil.getCalendarBookings(calendarIds, current, delta);
		long bookingsCount = ServiceUtil.getCalendarBookingsCount(calendarIds);

		renderRequest.setAttribute("calendarIds", calendarIds);
		renderRequest.setAttribute("bookings", bookings);
		renderRequest.setAttribute("bookingsCount", bookingsCount);

		super.doView(renderRequest, renderResponse);
	}

	@Override
	public void doEdit(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		List<Long> selectedIds = ParamUtil.getCalendarIds(renderRequest);
		List<Calendar> calendars = ServiceUtil.getCalendars();

		List<KeyValuePair> selectedCalendars = ServiceUtil.getSelectedCalendars(calendars, selectedIds);
		List<KeyValuePair> availableCalendars = ServiceUtil.getAvailableCalendars(calendars, selectedIds);

		renderRequest.setAttribute("selectedCalendars", selectedCalendars);
		renderRequest.setAttribute("availableCalendars", availableCalendars);

		super.doEdit(renderRequest, renderResponse);
	}

	public void savePreferences(ActionRequest actionRequest, ActionResponse actionResponse) {

		String[] values = ParamUtil.getParameterValues(actionRequest, "selectedCalendars", new String[0]);

		String selectedCalendars = String.join(StringPool.COMMA, values);

		System.err.println("saving preferences -> " + selectedCalendars);

		PortletPreferences preferences = actionRequest.getPreferences();
		try {
			preferences.setValue("selectedCalendars", selectedCalendars);
			preferences.store();
		} catch (Exception e) {
			SessionErrors.add(actionRequest, "error-saving-preferences");
			e.printStackTrace();
		}
	}

}

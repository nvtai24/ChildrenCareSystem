package controller.feedback.manager;

import dal.FeedbackDAO;
import dal.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Feedback;
import model.Service;

/**
 *
 * @author admin
 */
public class FeedbackListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        ServiceDAO serviceDAO = new ServiceDAO();

        List<Feedback> feedbackList = feedbackDAO.getAllFeedbackWithDetails();
        List<Service> serviceList = serviceDAO.getAllServices();

        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("serviceList", serviceList);

        request.getRequestDispatcher("dashboard/feedbacks.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        switch (action) {
            case "rating" -> {
                FeedbackFilterRating ffr = new FeedbackFilterRating();
                ffr.doPost(request, response);
            }
            case "service" -> {
                FeedbackFilterService ffs = new FeedbackFilterService();
                ffs.doPost(request, response);
            }
            case "status" -> {
                FeedbackFilterStatus ffs = new FeedbackFilterStatus();
                ffs.doPost(request, response);
            }
            case "search" -> {
                FeedbackSearch fs = new FeedbackSearch();
                fs.doPost(request, response);
            }
            case "change" -> {
                FeedbackChangeStatus fcs = new FeedbackChangeStatus();
                fcs.doPost(request, response);
            }
            default -> {
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                ServiceDAO serviceDAO = new ServiceDAO();

                List<Feedback> feedbackList = feedbackDAO.getAllFeedbackWithDetails();
                List<Service> serviceList = serviceDAO.getAllServices();

                request.setAttribute("feedbackList", feedbackList);
                request.setAttribute("serviceList", serviceList);

                request.getRequestDispatcher("dashboard/feedbacks.jsp").forward(request, response);
            }
        }
    }

    private class FeedbackFilterRating extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ServiceDAO serviceDAO = new ServiceDAO();

            HttpSession session = req.getSession();

            String rating_raw = req.getParameter("rating");
            Integer serviceId_raw = (Integer) session.getAttribute("sessionServiceId");
            Integer status_raw = (Integer) session.getAttribute("sessionStatus");

            int ratingSession = -1;
            int serviceIdSession = -1;
            int statusSession = -1;

            if (rating_raw != null) {
                ratingSession = Integer.parseInt(rating_raw);
            }

            if (serviceId_raw != null) {
                serviceIdSession = serviceId_raw;
            }

            if (status_raw != null) {
                statusSession = status_raw;
            }

            List<Service> serviceList = serviceDAO.getAllServices();
            List<Feedback> feedbackList = feedbackDAO.getListFeedbackByRatingServiceAndStatus(ratingSession, serviceIdSession, statusSession);

            req.setAttribute("feedbackList", feedbackList);
            req.setAttribute("serviceList", serviceList);
            session.setAttribute("sessionRating", ratingSession);
            session.setAttribute("sessionServiceId", serviceIdSession);
            session.setAttribute("sessionStatus", statusSession);

            req.getRequestDispatcher("dashboard/feedbacks.jsp").forward(req, resp);
        }
    }

    private class FeedbackFilterService extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ServiceDAO serviceDAO = new ServiceDAO();

            HttpSession session = req.getSession();

            Integer rating_raw = (Integer) session.getAttribute("sessionRating");
            String serviceId_raw = req.getParameter("service");
            Integer status_raw = (Integer) session.getAttribute("sessionStatus");

            int ratingSession = -1;
            int serviceIdSession = -1;
            int statusSession = -1;

            if (rating_raw != null) {
                ratingSession = rating_raw;
            }

            if (serviceId_raw != null) {
                serviceIdSession = Integer.parseInt(serviceId_raw.trim());
            }

            if (status_raw != null) {
                statusSession = status_raw;
            }

            List<Service> serviceList = serviceDAO.getAllServices();
            List<Feedback> feedbackList = feedbackDAO.getListFeedbackByRatingServiceAndStatus(ratingSession, serviceIdSession, statusSession);

            req.setAttribute("feedbackList", feedbackList);
            req.setAttribute("serviceList", serviceList);
            session.setAttribute("sessionRating", ratingSession);
            session.setAttribute("sessionServiceId", serviceIdSession);
            session.setAttribute("sessionStatus", statusSession);

            req.getRequestDispatcher("dashboard/feedbacks.jsp").forward(req, resp);
        }
    }

    private class FeedbackSearch extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            HttpSession session = req.getSession(false);

            if (session != null) {
                session.removeAttribute("sessionRating");
                session.removeAttribute("sessionServiceId");
                session.removeAttribute("sessionStatus");

            }

            String searchQuery = req.getParameter("search").trim();

            List<Service> serviceList = serviceDAO.getAllServices();
            List<Feedback> feedbackList = feedbackDAO.getFeedbackBySearch(searchQuery);

            req.setAttribute("feedbackList", feedbackList);
            req.setAttribute("serviceList", serviceList);
            req.setAttribute("searchQuery", searchQuery);

            req.getRequestDispatcher("dashboard/feedbacks.jsp").forward(req, resp);
        }
    }

    private class FeedbackChangeStatus extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            HttpSession session = req.getSession();

            String id_raw = req.getParameter("id");
            String status_raw = req.getParameter("status");

            int id = Integer.parseInt(id_raw);

            boolean currentStatus = Boolean.parseBoolean(status_raw);
            boolean newStatus = !currentStatus;

            feedbackDAO.updateFeedbackStatus(id, newStatus ? 1 : 0);

            Integer rating_raw = (Integer) session.getAttribute("sessionRating");
            Integer serviceId_raw = (Integer) session.getAttribute("sessionServiceId");
            Integer filterStatus_raw = (Integer) session.getAttribute("sessionStatus");

            int ratingSession = -1;
            int serviceIdSession = -1;
            int statusSession = -1;

            if (rating_raw != null) {
                ratingSession = rating_raw;
            }

            if (serviceId_raw != null) {
                serviceIdSession = serviceId_raw;
            }

            if (filterStatus_raw != null) {
                statusSession = filterStatus_raw;
            }

            List<Service> serviceList = serviceDAO.getAllServices();
            List<Feedback> feedbackList = feedbackDAO.getListFeedbackByRatingServiceAndStatus(ratingSession, serviceIdSession, statusSession);

            req.setAttribute("feedbackList", feedbackList);
            req.setAttribute("serviceList", serviceList);

            req.getRequestDispatcher("dashboard/feedbacks.jsp").forward(req, resp);
        }
    }

    private class FeedbackFilterStatus extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ServiceDAO serviceDAO = new ServiceDAO();

            HttpSession session = req.getSession();

            Integer rating_raw = (Integer) session.getAttribute("sessionRating");
            Integer serviceId_raw = (Integer) session.getAttribute("sessionServiceId");
            String status_raw = req.getParameter("status");

            int ratingSession = -1;
            int serviceIdSession = -1;
            int statusSession = -1;

            if (rating_raw != null) {
                ratingSession = rating_raw;
            }

            if (serviceId_raw != null) {
                serviceIdSession = serviceId_raw;
            }

            if (status_raw != null) {
                statusSession = Integer.parseInt(status_raw);
            }

            List<Service> serviceList = serviceDAO.getAllServices();
            List<Feedback> feedbackList = feedbackDAO.getListFeedbackByRatingServiceAndStatus(ratingSession, serviceIdSession, statusSession);

            req.setAttribute("feedbackList", feedbackList);
            req.setAttribute("serviceList", serviceList);
            session.setAttribute("sessionRating", ratingSession);
            session.setAttribute("sessionServiceId", serviceIdSession);
            session.setAttribute("sessionStatus", statusSession);

            req.getRequestDispatcher("dashboard/feedbacks.jsp").forward(req, resp);
        }
    }
}

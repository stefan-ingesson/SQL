using LibraryAccess;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Library.Models.Repository;
using Library.Models;

namespace Library.Controllers
{


    public class CustomerController : Controller
    {

        private readonly IRepository _repository;


        public CustomerController()
            : this(new DbRepository()) { }

        public CustomerController(IRepository repository)
        {
            _repository = repository;
        }


        public ActionResult Index()
        {
            return View(_repository.GetCustomers());
        }


        [HttpGet]
        public ActionResult Delete(int? id)
        {
            DeleteCustomer delete;
            using (var ctx = new BibliotekDatabasEntities())
            {
                var hasLoan = (from l in ctx.CurrentLoans
                               join c in ctx.UniqueBookCopies on l.CopyId equals c.CopyId
                               where l.CustomerId == id && c.Status > 1
                               select l).Any();
                delete = (from c in ctx.Customers
                          where c.CustomerId == id
                          select new DeleteCustomer
                          {
                              CustomerId = c.CustomerId,
                              FirstName = c.FirstName,
                              LastName = c.LastName,
                          }).FirstOrDefault();

            }
            return View(delete);
        }


        [HttpPost]
        [ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var customer = _repository.GetCustomerById(id);

            if (customer == null)
            {
                throw new HttpException(404, "Den valda kunden kunde inte hittas");
            }
            try
            {
                _repository.DeleteCustomer(customer.CustomerId);
                TempData["success"] = "Borttagning av kund genomförd";
            }
            catch (Exception)
            {
                TempData["error"] = "Kunden blev inte borttagen";
            }

            if (customer.CurrentLoan.Count > 0)
            {
                TempData["error"] = "Kunden kan inte tas bort när den har aktiva lån";
                return RedirectToAction("Index");
            }

            return RedirectToAction("Index");
        }
    }
}









using LibraryAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data.Entity;

namespace Library.Models.Repository
{
    public class DbRepository : Library.Models.Repository.IRepository
    {

        public IList<Customer> GetCustomers()
        {
            using (var ctx = new BibliotekDatabasEntities())
            {
                return ctx.Customers
                    .Include(x => x.CurrentLoans)
                    .ToList();
            }


        }

        public Customer GetCustomerById(int id)
        {
            return GetCustomers().Where(x => x.CustomerId == id).FirstOrDefault();
        }

        public void DeleteCustomer(int id)
        {
            using (var ctx = new BibliotekDatabasEntities())
            {
                var customer = new Customer { CustomerId = id };
                ctx.Customers.Attach(customer);
                ctx.Customers.Remove(customer);
                ctx.SaveChanges();
            }
        }




    }
}

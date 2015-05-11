using System;
namespace Library.Models.Repository
{
   public interface IRepository
    {
        void DeleteCustomer(int id);
        LibraryAccess.Customer GetCustomerById(int id);
        System.Collections.Generic.IList<LibraryAccess.Customer> GetCustomers();
    }
}

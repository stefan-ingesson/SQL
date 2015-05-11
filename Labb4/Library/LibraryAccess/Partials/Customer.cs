using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace LibraryAccess
{
    [MetadataType(typeof(Customer))]  
    public partial class Customer
    {
        public string FullName
        {
            get { return string.Format("{0} {1}", this.FirstName, this.LastName); }
        }

        public IList<CurrentLoan> CurrentLoan
        {
            get { return this.CurrentLoans.Where(x => !x.IsReturned).ToList(); }
        }


        public bool HasDelayedBook
        {
            get { return this.CurrentLoans.Where(x => x.DueDate < DateTime.Now && x.IsReturned == false).ToList().Count > 1; }
        }
        //public IList<Loan> OldLoans
        //{
        //    get { return this.Loans.Where(x => x.IsReturned).ToList(); }
        //}
    }
}

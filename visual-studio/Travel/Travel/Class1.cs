using System;
using System.Collections.Generic;
using System.Text;

namespace Travel
{
    class Country
    {
        private string _code;
        private string _name;

        public string Code { get => _code; set => _code = value; }
        public string Name { get => _name; set => _name = value; }

        public override string ToString()
        {
            return string.Format("%s (%s)", Name, Code);
        }
    }
    class City
    {
        private int _id;
        private double _lat;
        private double _lon;
        private string _name;
        // TODO: string country code ou Country country?

        public int Id { get => _id; set => _id = value; }
        public double Lat { get => _lat; set => _lat = value; }
        public double Lon { get => _lon; set => _lon = value; }
        public string Name { get => _name; set => _name = value; }

        public override string ToString()
        {
            return string.Format("%s", Name);
        }
    }

    class Monument
    {
        private int _id;
        private double _lat;
        private double _lon;
        private string _name;
        // era
        // city

        public int Id { get => _id; set => _id = value; }
        public double Lat { get => _lat; set => _lat = value; }
        public double Lon { get => _lon; set => _lon = value; }
        public string Name { get => _name; set => _name = value; }
    }

    class Guide
    {
        private string _email;
        private string _name;
        private DateTime _birthDate;
        private int _id;

        public string Email { get => _email; set => _email = value; }
        public string Name { get => _name; set => _name = value; }
        public DateTime BirthDate { get => _birthDate; set => _birthDate = value; }
        public int Id { get => _id; set => _id = value; }

        public override string ToString()
        {
            return string.Format("");
        }
    }

    class Tourist
    {
        private string _email;
        private string _name;
        private DateTime _birthDate;
        public string Email { get => _email; set => _email = value; }
        public string Name { get => _name; set => _name = value; }
        public DateTime BirthDate { get => _birthDate; set => _birthDate = value; }
    }

    class Tariff
    {
        private int _id;
        private double _priceSpring;
        private double _priceSummer;
        private double _priceAutumn;
        private double _priceWinter;

        public int Id { get => _id; set => _id = value; }
        public double PriceSpring { get => _priceSpring; set => _priceSpring = value; }
        public double PriceSummer { get => _priceSummer; set => _priceSummer = value; }
        public double PriceAutumn { get => _priceAutumn; set => _priceAutumn = value; }
        public double PriceWinter { get => _priceWinter; set => _priceWinter = value; }
    }

    enum TourType
    {
        Both,
        Location,
        Time
    }

    class Tour
    {
        private int _id;
        private string _name;
        private string _desc;
        private int _duration;

        public int Id { get => _id; set => _id = value; }
        public string Name { get => _name; set => _name = value; }
        public string Desc { get => _desc; set => _desc = value; }
        public int Duration { get => _duration; set => _duration = value; }
        // tour type
        // tariff
    }

    class VirtualTour
    {
        // tour
        private string _accessLink;
        private string _password;

        public string AccessLink { get => _accessLink; set => _accessLink = value; }
        public string Password { get => _password; set => _password = value; }
    }

    class PresentialTour
    {
        // tour
        private string _startLocation;
        private string _endLocation;

        public string StartLocation { get => _startLocation; set => _startLocation = value; }
        public string EndLocation { get => _endLocation; set => _endLocation = value; }
    }

    class TourInstance
    {
        private DateTime _startDate;
        // tour
        // guide

        public DateTime StartDate { get => _startDate; set => _startDate = value; }
    }

    // tour_includes_monument?
    // tourist_participates?
}

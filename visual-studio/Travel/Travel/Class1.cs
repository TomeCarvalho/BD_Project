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
        private string _country_code;

        public int Id { get => _id; set => _id = value; }
        public double Lat { get => _lat; set => _lat = value; }
        public double Lon { get => _lon; set => _lon = value; }
        public string Name { get => _name; set => _name = value; }
        public string Country_code { get => _country_code; set => _country_code = value; }

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
        private string _eraDesignation;
        private string _cityId;

        public int Id { get => _id; set => _id = value; }
        public double Lat { get => _lat; set => _lat = value; }
        public double Lon { get => _lon; set => _lon = value; }
        public string Name { get => _name; set => _name = value; }
        public string EraDesignation { get => _eraDesignation; set => _eraDesignation = value; }
        public string CityId { get => _cityId; set => _cityId = value; }
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
        private string _typeDesignation;
        private int _tariffId;

        public int Id { get => _id; set => _id = value; }
        public string Name { get => _name; set => _name = value; }
        public string Desc { get => _desc; set => _desc = value; }
        public int Duration { get => _duration; set => _duration = value; }
        public string TypeDesignation { get => _typeDesignation; set => _typeDesignation = value; }
        public int TariffId { get => _tariffId; set => _tariffId = value; }
    }

    class VirtualTour
    {
        private int _tourId;
        private string _accessLink;
        private string _password;

        public string AccessLink { get => _accessLink; set => _accessLink = value; }
        public string Password { get => _password; set => _password = value; }
        public int TourId { get => _tourId; set => _tourId = value; }
    }

    class PresentialTour
    {
        private int _tourId;
        private string _startLocation;
        private string _endLocation;

        public string StartLocation { get => _startLocation; set => _startLocation = value; }
        public string EndLocation { get => _endLocation; set => _endLocation = value; }
        public int TourId { get => _tourId; set => _tourId = value; }
    }

    class TourInstance
    {
        private DateTime _startDate;
        private int _tourId;
        private int _guideId;

        public DateTime StartDate { get => _startDate; set => _startDate = value; }
        public int TourId { get => _tourId; set => _tourId = value; }
        public int GuideId { get => _guideId; set => _guideId = value; }
    }

    class TourIncludesMonument
    {
        private int _monumentId;
        private int _tourId;

        public int MonumentId { get => _monumentId; set => _monumentId = value; }
        public int TourId { get => _tourId; set => _tourId = value; }
    }

    class TouristParticipates
    {
        private string _touristEmail;
        private int _tourId;
        private DateTime _startDate;

        public string TouristEmail { get => _touristEmail; set => _touristEmail = value; }
        public int TourId { get => _tourId; set => _tourId = value; }
        public DateTime StartDate { get => _startDate; set => _startDate = value; }
    }
}

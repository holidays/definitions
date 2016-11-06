require 'date'

# Used by ar, at
# (so far)
def print_tests(name, date, regions, options = nil)
  puts "  - given:"
  puts "      date: '#{date}'"
  puts "      regions: #{regions}"

  if options
    puts "      options: #{options}"
  end

  puts "    expect:"
  if name == 'Not a holiday'
    puts "      holiday: false"
  else
    puts "      name: \"#{name}\""
  end
end

# Used by au
# (so far)
def process_data(name, values)
  dates = values[0]
  if values[1].is_a?(Array)
    regions = values[1]
  else
    regions = [values[1].to_s]
  end
  options = [values[2].to_s] unless values[2].nil?

	if dates.is_a?(Array)
		dates.each do |d|
			print_tests(name, d, regions, options)
		end
	else
		print_tests(name, dates, regions, options)
	end
end

# ve
#{
#  Date.civil(2013, 1, 1) => "Año Nuevo",
#  Date.civil(2013, 2, 11) => "Lunes Carnaval",
#  Date.civil(2013, 2, 12) => "Martes Carnaval",
#  Date.civil(2013, 3, 28) => "Jueves Santo",
#  Date.civil(2013, 3, 29) => "Viernes Santo",
#  Date.civil(2013, 4, 19) => "Declaración Independencia",
#  Date.civil(2013, 5, 1) => "Día del Trabajador",
#  Date.civil(2013, 6, 24) => "Aniversario Batalla de Carabobo",
#  Date.civil(2013, 7, 5) => "Día de la Independencia",
#  Date.civil(2013, 7, 24) => "Natalicio de Simón Bolívar",
#  Date.civil(2013, 10, 12) => "Día de la Resistencia Indígena",
#  Date.civil(2013, 12, 25) => "Día de Navidad"
#}.each do |date, name|
#  print_tests(name, date, ["ve"])
#end

# el
#{
#	Date.civil(2011,1,1) => 'Πρωτοχρονιά',
#	Date.civil(2011,1,6) => 'Θεοφάνεια',
#	Date.civil(2011,4,22) => 'Μεγάλη Παρασκευή',
#	Date.civil(1970,4,25) => 'Μεγάλο Σάββατο',
#	Date.civil(1985,4,14) => 'Κυριακή του Πάσχα',
#	Date.civil(2011,4,24) => 'Κυριακή του Πάσχα',
#	Date.civil(2027,5,2) => 'Κυριακή του Πάσχα',
#	Date.civil(2046,4,30) => 'Δευτέρα του Πάσχα',
#	Date.civil(2011,5,1) => 'Πρωτομαγιά',
#	Date.civil(2011,6,13) => 'Αγίου Πνεύματος',
#	Date.civil(2012,6,4) => 'Αγίου Πνεύματος',
#	Date.civil(2011,3,7) => 'Καθαρά Δευτέρα',
#	Date.civil(2012,2,27) => 'Καθαρά Δευτέρα',
#	Date.civil(2011,12,25) => 'Χριστούγεννα',
#	Date.civil(2011,12,26) => 'Δεύτερη ημέρα των Χριστουγέννων'
#}.each do |date, name|
#  print_tests(name, date, ["el"], ["informal"])
#end

# ecb_target
#{
#	Date.civil(2013,1,1) => 'New Year\'s Day',
#	Date.civil(2013,5,1) => 'Labour Day',
#	Date.civil(2013,3,29) => 'Good Friday',
#	Date.civil(2013,4,1) => 'Easter Monday',
#	Date.civil(2013,12,25) => 'Christmas Day',
#	Date.civil(2013,12,26) => 'Christmas Holiday'
#}.each do |date, name|
#  print_tests(name, date, ["ecb_target"])
#end
#
#print_tests('Good Friday', Date.civil(2013, 3, 29), ["ecb_target"])
#print_tests('Easter Monday', Date.civil(2013, 4, 1), ["ecb_target"])

# dk
#{
#	Date.civil(2007,1,1) => 'Nytårsdag',
#	Date.civil(2007,2,18) => 'Fastelavn',
#	Date.civil(2007,4,9) => 'Danmarks besættelse',
#	Date.civil(2007,4,16) => 'Dronningens fødselsdag',
#	Date.civil(2007,4,5) => 'Skærtorsdag',
#	Date.civil(2007,4,6) => 'Langfredag',
#	Date.civil(2007,4,8) => 'Påskedag',
#	Date.civil(2007,4,9) => '2. påskedag',
#	Date.civil(2007,5,1) => 'Arbejdernes kampdag',
#	Date.civil(2007,5,4) => 'Store Bededag',
#	Date.civil(2007,5,17) => 'Kristi Himmelfartsdag',
#	Date.civil(2007,5,27) => 'Pinsedag',
#	Date.civil(2007,5,28) => '2. Pinsedag',
#	Date.civil(2007,6,5) => 'Grundlovsdag',
#	Date.civil(2007,12,24) => 'Juleaftensdag',
#	Date.civil(2007,12,25) => '1. juledag',
#	Date.civil(2007,12,26) => '2. juledag'
#}.each do |date, name|
#  print_tests(name, date, ["dk"], ["informal"])
#end

# de
#{
#  Date.civil(2009,1,1) => 'Neujahrstag',
#  Date.civil(2009,4,10) => 'Karfreitag',
#  Date.civil(2009,4,12) => 'Ostersonntag',
#  Date.civil(2009,4,13) => 'Ostermontag',
#  Date.civil(2009,5,1) => 'Tag der Arbeit',
#  Date.civil(2009,5,21) => 'Christi Himmelfahrt',
#  Date.civil(2009,5,31) => 'Pfingstsonntag',
#  Date.civil(2009,6,1) => 'Pfingstmontag',
#  Date.civil(2009,10,3) => 'Tag der Deutschen Einheit',
#  Date.civil(2009,12,24) => 'Heilig Abend',
#  Date.civil(2009,12,25) => '1. Weihnachtstag',
#  Date.civil(2009,12,26) => '2. Weihnachtstag',
#  Date.civil(2009,12,31) => 'Silvester'
#}.each do |date, name|
#	print_tests(name, date, ["de"], ["informal"])
#end
#
#print_tests('Heilige Drei Könige', Date.civil(2009, 1, 6), ["de_bw", "de_by", "de_st", "de_"])
#print_tests('Fronleichnam', Date.civil(2009, 6, 11), ["de_bw", "de_by", "de_he", "de_nw", "de_rp", "de_sl", "de_sn_sorbian", "de_th_eichsfeld", "de_"])
#print_tests('Mariä Himmelfahrt', Date.civil(2009, 8, 15), ["de_by", "de_sl", "de_"])
#print_tests('Reformationstag', Date.civil(2009, 10, 31), ["de_bb", "de_mv", "de_sn", "de_st", "de_th", "de_"])
#
## Free day in schools
#print_tests('Reformationstag', Date.civil(2009, 10, 31), ["de_bw"], ["informal"])
#
## 500 years reformation in 2017
#print_tests('Reformationstag', Date.civil(2017, 10, 31), ["de"])
#print_tests('Not a holiday', Date.civil(2016, 10, 31), ["de"])
#print_tests('Not a holiday', Date.civil(2018, 10, 31), ["de"])
#
#print_tests('Allerheiligen', Date.civil(2009, 11, 1), ["de_bw", "de_by", "de_nw", "de_rp", "de_sl", "de_"])
#
#print_tests('Friedensfest', Date.civil(2015, 8, 8), ["de_by_augsburg"])
#
#print_tests('Not a holiday', Date.civil(2015, 8, 8), ["de", "de_bw", "de_by", "de_bb", "de_he", "de_mv", "de_nw", "de_rp", "de_sl", "de_sn", "de_st", "de_th"])
#
#print_tests('Not a holiday', Date.civil(2010, 5, 8), ["de"])
#print_tests('Not a holiday', Date.civil(2010, 8, 8), ["de"])
#
## Repentance Day
#print_tests('Buß- und Bettag', Date.civil(2004, 11, 17), ["de_sn"])
#print_tests('Buß- und Bettag', Date.civil(2005, 11, 16), ["de_sn"])
#print_tests('Buß- und Bettag', Date.civil(2006, 11, 22), ["de_sn"])
#print_tests('Buß- und Bettag', Date.civil(2009, 11, 18), ["de_sn"])
#
## Carnival
#print_tests('Weiberfastnacht', Date.civil(2016, 2, 4), ["de_bw", "de_by", "de_he", "de_nw", "de_rp", "de_sl", "de_sn"], ["informal"])
#print_tests('Rosenmontag', Date.civil(2016, 2, 8), ["de_bw", "de_by", "de_he", "de_nw", "de_rp", "de_sl", "de_sn"], ["informal"])
#print_tests('Aschermittwoch', Date.civil(2016, 2, 10), ["de_bw", "de_by", "de_he", "de_nw", "de_rp", "de_sl", "de_sn"], ["informal"])

# za
#{
#	Date.civil(2007,1,1) => 'New Year\'s Day',
#	Date.civil(2007,3,21) => 'Human Rights Day',
#	Date.civil(2007,4,6) => 'Good Friday',
#	Date.civil(2007,4,9) => 'Family Day',
#	Date.civil(2007,4,27) => 'Freedom Day',
#	Date.civil(2007,5,1) => 'Workers Day',
#	Date.civil(2007,6,16) => 'Youth Day',
#	Date.civil(2007,8,9) => 'National Women\'s Day',
#	Date.civil(2007,9,24) => 'Heritage Day',
#	Date.civil(2007,12,16) => 'Day of Reconciliation',
#	Date.civil(2007,12,25) => 'Christmas Day',
#	Date.civil(2007,12,26) => 'Day of Goodwill'
#}.each do |date, name|
#	print_tests(name, date, ["za"], ["informal"])
#end

# vi
#{
#	Date.civil(2014,1,1) => 'New Year',
#	Date.civil(2014,4,30) => 'Liberation Day',
#	Date.civil(2014,5,1) => "International Workers' Day",
#	Date.civil(2014,9,2) => 'National Day'
#}.each do |date, name|
#	print_tests(name, date, ["vi"])
#end

# us
#{
#	Date.civil(2008,1,1) => 'New Year\'s Day',
#	Date.civil(2008,1,21) => 'Martin Luther King, Jr. Day',
#	Date.civil(2008,2,18) => 'Presidents\' Day',
#	Date.civil(2008,5,26) => 'Memorial Day',
#	Date.civil(2008,7,4) => 'Independence Day',
#	Date.civil(2008,9,1) => 'Labor Day',
#	Date.civil(2008,10,13) => 'Columbus Day',
#	Date.civil(2008,11,11) => 'Veterans Day',
#	Date.civil(2008,11,27) => 'Thanksgiving',
#	Date.civil(2013,11,28) => 'Thanksgiving',
#	Date.civil(2008,12,25) => 'Christmas Day'
#}.each do |date, name|
#	print_tests(name, date, ["us"])
#end
#
#{
#	Date.civil(2008, 3, 31) => 'Cesar Chavez Day',
#	Date.civil(2008, 11, 28) => 'Day after Thanksgiving',
#	Date.civil(2013, 11, 29) => 'Day after Thanksgiving'
#}.each do |date, name|
#	print_tests(name, date, ["us", "us_ca"])
#end

#ups
#{
#	Date.civil(2008,1,1) => 'New Year\'s Day',
#	Date.civil(2008,5,26) => 'Memorial Day',
#	Date.civil(2008,7,4) => 'Independence Day',
#	Date.civil(2008,9,1) => 'Labor Day',
#	Date.civil(2008,11,27) => 'Thanksgiving',
#	Date.civil(2008,11,28) => 'Day After Thanksgiving',
#	Date.civil(2013,11,28) => 'Thanksgiving',
#	Date.civil(2013,11,29) => 'Day After Thanksgiving',
#	Date.civil(2008,12,25) => 'Christmas Day',
#	Date.civil(2008,12,31) => 'New Year\'s Eve',}.each do |date, name|
#		print_tests(name, date, ["ups"])
#	end
#

# tn
#{
#	Date.civil(2016,1,1)   => "Jour de l'an",
#	Date.civil(2016,1,14)  => "Fête de la Révolution et de la Jeunesse",
#	Date.civil(2016,3,20)  => "Fête de l'Indépendance",
#	Date.civil(2016,4,9)   => "Journée des Martyrs",
#	Date.civil(2016,5,1)   => "Fête du travail",
#	Date.civil(2016,7,25)  => "Fête de la République",
#	Date.civil(2016,8,13)  => "Fête de la Femme et de la Famille",
#	Date.civil(2016,10,15) => "Fête de l'Évacuation",
#}.each do |date, name|
#	print_tests(name, date, ["tn"])
#end

#sk
#{
#	Date.civil(2013,1,1) => 'Nový rok',
#	Date.civil(2013,1,6) => 'Zjavenie Pána (Traja králi)',
#	Date.civil(2013,3,29) => 'Veľký piatok',
#	Date.civil(2013,4,1) => 'Veľkonočný pondelok',
#	Date.civil(2013,5,1) => 'Sviatok práce',
#	Date.civil(2013,5,8) => 'Deň víťazstva nad fašizmom',
#	Date.civil(2013,7,5) => 'Sviatok svätého Cyrila a svätého Metoda',
#	Date.civil(2013,8,29) => 'Výročie Slovenského národného povstania',
#	Date.civil(2013,9,1) => 'Deň Ústavy Slovenskej republiky',
#	Date.civil(2013,9,15) => 'Sedembolestná Panna Mária',
#	Date.civil(2013,11,1) => 'Sviatok všetkých svätých',
#	Date.civil(2013,11,17) => 'Deň boja za slobodu a demokraciu',
#	Date.civil(2013,12,24) => 'Štedrý deň',
#	Date.civil(2013,12,25) => '1. sviatok vianočný',
#	Date.civil(2013,12,26) => '2. sviatok vianočný'
#}.each do |date, name|
#  print_tests(name, date, ["sk"], ["informal"])
#end

# si
#print_tests('velikonočna nedelja', Date.civil(2015, 4, 5), ["si"])
#print_tests('velikonočna nedelja', Date.civil(2016, 3, 27), ["si"])
#print_tests('velikonočni ponedeljek', Date.civil(2015, 4, 6), ["si"])
#print_tests('velikonočni ponedeljek', Date.civil(2016, 3, 28), ["si"])
#print_tests('binkošti', Date.civil(2015, 5, 24), ["si"])
#print_tests('binkošti', Date.civil(2016, 5, 15), ["si"])
#
#(2014..2014).each do |year|
#	{Date.civil(year,1,1) => 'novo leto',
#	Date.civil(year,2,8) => 'Prešernov dan, slovenski kulturni praznik',
#	Date.civil(year,4,27) => 'dan upora proti okupatorju',
#	Date.civil(year,5,1) => 'praznik dela',
#	Date.civil(year,5,2) => 'praznik dela',
#	Date.civil(year,6,25) => 'dan državnosti',
#	Date.civil(year,8,15) => 'Marijino vnebovzetje',
#	Date.civil(year,10,31) => 'dan reformacije',
#	Date.civil(year,11,1) => 'dan spomina na mrtve',
#	Date.civil(year,12,25) => 'božič',
#	Date.civil(2008,12,26) => 'dan samostojnosti in enotnosti'}.each do |date, name|
#    print_tests(name, date, ["si"], ["informal"])
#	end
#end

# sg
#{
#	Date.civil(2014,1,1) => 'New Year\'s Day',
#	Date.civil(2014,2,14) => 'Valentine\'s Day',
#	Date.civil(2014,2,15) => 'Total Defence Day',
#	Date.civil(2014,4,18) => 'Good Friday',
#	Date.civil(2014,5,1) => 'Labour Day',
#	Date.civil(2014,8,9) => 'National Day',
#	Date.civil(2014,12,25) => 'Christmas Day'
#}.each do |date, name|
#	print_tests(name, date, ["sg"], ["informal"])
#end

# se
#{
#	Date.civil(2008,1,1) => 'Nyårsdagen',
#	Date.civil(2008,1,6) => 'Trettondedag jul',
#	Date.civil(2008,3,21) => 'Långfredagen',
#	Date.civil(2008,3,22) => 'Påskafton',
#	Date.civil(2008,3,23) => 'Påskdagen',
#	Date.civil(2008,3,24) => 'Annandag påsk',
#	Date.civil(2008,5,1) => 'Första maj',
#	Date.civil(2008,5,1) => 'Kristi himmelsfärdsdag',
#	Date.civil(2008,5,11) => 'Pingstdagen',
#	Date.civil(2008,6,6) => 'Nationaldagen',
#	Date.civil(2005,6,25) => 'Midsommardagen',
#	Date.civil(2006,6,24) => 'Midsommardagen',
#	Date.civil(2006,6,23) => 'Midsommarafton',
#	Date.civil(2007,6,23) => 'Midsommardagen',
#	Date.civil(2007,6,22) => 'Midsommarafton',
#	Date.civil(2008,6,21) => 'Midsommardagen',
#	Date.civil(2008,6,20) => 'Midsommarafton',
#	Date.civil(2005,11,5) => 'Alla helgons dag',
#	Date.civil(2006,11,4) => 'Alla helgons dag',
#	Date.civil(2007,11,3) => 'Alla helgons dag',
#	Date.civil(2008,11,1) => 'Alla helgons dag',
#	Date.civil(2008,12,24) => 'Julafton',
#	Date.civil(2008,12,25) => 'Juldagen',
#	Date.civil(2008,12,26) => 'Annandag jul',
#	Date.civil(2008,12,31) => 'Nyårsafton'
#}.each do |date, name|
#	print_tests(name, date, ["se"], ["informal"])
#end

# ro
#{
#	Date.civil(1961,4,9) => 'Paștele - duminică',
#	Date.civil(1961,4,10) => 'Paștele - luni',
#	Date.civil(2013,5,5) => 'Paștele - duminică',
#	Date.civil(2013,5,6) => 'Paștele - luni',
#	Date.civil(2027,5,2) => 'Paștele - duminică',
#	Date.civil(2027,5,3) => 'Paștele - luni',
#	Date.civil(2012,6,4) => 'Rusaliile - 51',
#	Date.civil(2013,6,23) => 'Rusaliile - 50',
#	Date.civil(2013,6,24) => 'Rusaliile - 51',
#	Date.civil(1986,6,22) => 'Rusaliile - 50',
#	Date.civil(1986,6,23) => 'Rusaliile - 51',
#	Date.civil(2009,1,1) => 'Anul nou',
#	Date.civil(2014,1,2) => 'Anul nou',
#	Date.civil(2009,5,1) => 'Ziua muncii',
#	Date.civil(2012,8,15) => 'Adormirea Maicii Domnului',
#	Date.civil(2013,11,30) => 'Sfântul Apostol Andrei',
#	Date.civil(2013,12,1) => 'Ziua Națională',
#	Date.civil(2013,12,25) => 'Sărbătoarea Nașterii Domnului',
#	Date.civil(2013,12,26) => 'Sărbătoarea Nașterii Domnului'
#}.each do |date, name|
#	print_tests(name, date, ["ro"], ["informal"])
#end
#
#print_tests("Not a holiday", Date.civil(2013, 7, 23), ["ro"])

# pt
#{Date.civil(2008,1,1) => 'Ano Novo',
# Date.civil(2005,2,8) => 'Carnaval',
# Date.civil(2006,2,28) => 'Carnaval',
# Date.civil(2007,2,20) => 'Carnaval',
# Date.civil(2008,2,5) => 'Carnaval',
# Date.civil(2008,3,21) => 'Sexta-feira Santa',
# Date.civil(2008,3,23) => 'Páscoa',
# Date.civil(2016,3,27) => 'Páscoa',
# Date.civil(2008,4,25) => 'Dia da Liberdade',
# Date.civil(2008,5,1) => 'Dia do Trabalhador',
# Date.civil(2016,5,26) => 'Corpo de Deus',
# Date.civil(2008,6,10) => 'Dia de Portugal',
# Date.civil(2008,8,15) => 'Assunção de Nossa Senhora',
# Date.civil(2008,10,5) => 'Dia da República',
# Date.civil(2008,11,1) => 'Dia de Todos-os-Santos',
# Date.civil(2008,12,1) => 'Restauração da Independência',
# Date.civil(2008,12,8) => 'Imaculada Conceição',
# Date.civil(2008,12,25) => 'Natal'}.each do |date, name|
#	print_tests(name, date, ["pt"], ["informal"])
# end

# pl
#{
#	Date.civil(2011,1,1) => 'Nowy Rok',
#	Date.civil(2011,5,1) => 'Święto Państwowe (Święto Pracy)',
#	Date.civil(2011,5,3) => 'Święto Narodowe Trzeciego Maja',
#	Date.civil(2011,11,1) => 'Wszystkich Świętych',
#	Date.civil(2011,11,11) => 'Narodowe Święto Niepodległości',
#	Date.civil(2011,12,25) => 'pierwszy dzień Bożego Narodzenia',
#	Date.civil(2011,12,26) => 'drugi dzień Bożego Narodzenia'
#}.each do |date, name|
#	print_tests(name, date, ["pl"])
#end
#
## informal
#{
#	Date.civil(2011,1,21) => 'Dzień Babci',
#	Date.civil(2011,1,22) => 'Dzień Dziadka',
#	Date.civil(2011,2,2) => 'Ofiarowanie Pańskie (Matki Boskiej Gromnicznej)',
#	Date.civil(2011,2,14) => 'Dzień Zakochanych (Walentynki)',
#	Date.civil(2010,3,8) => 'Dzień Kobiet',
#	Date.civil(2011,3,10) => 'Dzień Mężczyzn',
#	Date.civil(2011,4,1) => 'Prima Aprilis',
#	Date.civil(2010,4,22) => 'Międzynarodowy Dzień Ziemi',
#	Date.civil(2011,5,2) => 'Dzień Flagi Rzeczpospolitej Polskiej',
#	Date.civil(2010,6,23) => 'Dzień Ojca',
#	Date.civil(2011,9,30) => 'Dzień Chłopaka',
#	Date.civil(2011,10,14) => 'Dzień Nauczyciela (Dzień Edukacji Narodowej)',
#	Date.civil(2011,11,2) => 'Dzień Zaduszny',
#	Date.civil(2011,11,29) => 'Andrzejki',
#	Date.civil(2011,12,4) => 'Barbórka (Dzień Górnika, Naftowca i Gazownika)',
#	Date.civil(2011,12,6) => 'Mikołajki',
#	Date.civil(2011,12,24) => 'Wigilia Bożego Narodzenia',
#	Date.civil(2011,12,31) => 'Sylwester'
#}.each do |date, name|
#	print_tests(name, date, ["pl"], ["informal"])
#end
#
## not found if informal is not sent
#{
#	Date.civil(2011,1,21) => 'Dzień Babci',
#	Date.civil(2011,1,22) => 'Dzień Dziadka',
#	Date.civil(2011,2,2) => 'Ofiarowanie Pańskie (Matki Boskiej Gromnicznej)',
#	Date.civil(2011,2,14) => 'Dzień Zakochanych (Walentynki)',
#	Date.civil(2010,3,8) => 'Dzień Kobiet',
#	Date.civil(2011,3,10) => 'Dzień Mężczyzn',
#	Date.civil(2011,4,1) => 'Prima Aprilis',
#	Date.civil(2010,4,22) => 'Międzynarodowy Dzień Ziemi',
#	Date.civil(2011,5,2) => 'Dzień Flagi Rzeczpospolitej Polskiej',
#	Date.civil(2010,6,23) => 'Dzień Ojca',
#	Date.civil(2011,9,30) => 'Dzień Chłopaka',
#	Date.civil(2011,10,14) => 'Dzień Nauczyciela (Dzień Edukacji Narodowej)',
#	Date.civil(2011,11,2) => 'Dzień Zaduszny',
#	Date.civil(2011,11,29) => 'Andrzejki',
#	Date.civil(2011,12,4) => 'Barbórka (Dzień Górnika, Naftowca i Gazownika)',
#	Date.civil(2011,12,6) => 'Mikołajki',
#	Date.civil(2011,12,24) => 'Wigilia Bożego Narodzenia',
#	Date.civil(2011,12,31) => 'Sylwester'
#}.each do |date, name|
#	print_tests("Not a holiday", date, ["pl"])
#end
#
## Objawienie Pańskie (święto Trzech Króli) -- formal since 2011
#[
#	Date.civil(2008,1,6), Date.civil(2009,1,6), Date.civil(2010,1,6)
#].each do |date|
#	print_tests("Not a holiday", date, ["pl"])
#end
#
#[
#	Date.civil(2008,1,6), Date.civil(2009,1,6), Date.civil(2010,1,6)
#].each do |date|
#	print_tests('Objawienie Pańskie (święto Trzech Króli)', date, ["pl"], ["informal"])
#end
#
#[
#	Date.civil(2011,1,6), Date.civil(2012,1,6), Date.civil(2013,1,6)
#].each do |date|
#	print_tests('Objawienie Pańskie (święto Trzech Króli)', date, ["pl"])
#end
#
## Tłusty Czwartek
#[
#	Date.civil(2008,1,31), Date.civil(2009,2,19), Date.civil(2010,2,11),
#	Date.civil(2011,3,3), Date.civil(2012,2,16)
#].each do |date|
#	print_tests('Tłusty Czwartek', date, ["pl"], ["informal"])
#end
#
## Ostatki
#[
#	Date.civil(2008,2,5), Date.civil(2009,2,24), Date.civil(2010,2,16),
#	Date.civil(2011,3,8), Date.civil(2012,2,21)
#].each do |date|
#	print_tests('Ostatki', date, ["pl"], ["informal"])
#end
#
## Środa Popielcowa
#[
#	Date.civil(2008,2,6), Date.civil(2009,2,25), Date.civil(2010,2,17),
#	Date.civil(2011,3,9), Date.civil(2012,2,22)
#].each do |date|
#	print_tests('Środa Popielcowa', date, ["pl"], ["informal"])
#end
#
## Niedziela Palmowa
#[Date.civil(2008,3,16), Date.civil(2009,4,5), Date.civil(2010,3,28),
# Date.civil(2011,4,17), Date.civil(2012,4,1)].each do |date|
#	print_tests('Niedziela Palmowa', date, ["pl"], ["informal"])
#end
#
## Wielki Czwartek
#[Date.civil(2008,3,20), Date.civil(2009,4,9), Date.civil(2010,4,1),
# Date.civil(2011,4,21), Date.civil(2012,4,5)].each do |date|
#	print_tests('Wielki Czwartek', date, ["pl"], ["informal"])
#end
#
## Wielki Piątek
#[Date.civil(2008,3,21), Date.civil(2009,4,10), Date.civil(2010,4,2),
# Date.civil(2011,4,22), Date.civil(2012,4,6)].each do |date|
#	print_tests('Wielki Piątek', date, ["pl"], ["informal"])
#end
#
## Wielka Sobota
#[Date.civil(2008,3,22), Date.civil(2009,4,11), Date.civil(2010,4,3),
# Date.civil(2011,4,23), Date.civil(2012,4,7)].each do |date|
#	print_tests('Wielka Sobota', date, ["pl"], ["informal"])
#end
#
## Niedziela Wielkanocna
#[Date.civil(2008,3,23), Date.civil(2009,4,12), Date.civil(2010,4,4),
# Date.civil(2011,4,24), Date.civil(2012,4,8)].each do |date|
#	print_tests('Niedziela Wielkanocna', date, ["pl"])
#end
#
## Poniedziałek Wielkanocny (Lany Poniedziałek)
#[Date.civil(2008,3,24), Date.civil(2009,4,13), Date.civil(2010,4,5),
# Date.civil(2011,4,25), Date.civil(2012,4,9)].each do |date|
#	print_tests('Poniedziałek Wielkanocny (Lany Poniedziałek)', date, ["pl"])
#end
#
## Zesłanie Ducha Świętego (Zielone Świątki)
#[Date.civil(2008,5,11), Date.civil(2009,5,31), Date.civil(2010,5,23),
# Date.civil(2011,6,12), Date.civil(2012,5,27)].each do |date|
#	print_tests('Zesłanie Ducha Świętego (Zielone Świątki)', date, ["pl"])
#end
#
## Uroczystość Najświętszego Ciała i Krwi Pańskiej (Boże Ciało)
#[Date.civil(2008,5,22), Date.civil(2009,6,11), Date.civil(2010,6,3),
# Date.civil(2011,6,23), Date.civil(2012,6,7)].each do |date|
#	print_tests('Uroczystość Najświętszego Ciała i Krwi Pańskiej (Boże Ciało)', date, ["pl"])
#end
#
## Wniebowzięcie Najświętszej Maryi Panny & Święto Wojska Polskiego
#print_tests('Wniebowzięcie Najświętszej Maryi Panny', Date.civil(2011, 8, 15), ["pl"])
#print_tests('Święto Wojska Polskiego', Date.civil(2011, 8, 15), ["pl"])
#
# ph
#{
#	Date.civil(2015,4,3) => 'Good Friday',
#	Date.civil(2015,4,9) => 'The Day of Valor',
#	Date.civil(2015,5,1) => 'Labor Day',
#	Date.civil(2015,6,12) => 'Independence Day',
#	Date.civil(2015,8,21) => 'Ninoy Aquino Day',
#	Date.civil(2015,8,31) => 'National Heroes Day',
#	Date.civil(2015,11,30) => 'Bonifacio Day',
#	Date.civil(2015,12,25) => 'Christmas Day',
#	Date.civil(2015,12,30) => 'Rizal Day'
#}.each do |date, name|
#	print_tests(name, date, ["ph"])
#end

# pe
#{
#	Date.civil(2016,1,1) => 'Año Nuevo',
#	Date.civil(2016,1,6) => 'Día de los Reyes Magos',
#	Date.civil(2016,3,24) => 'Jueves Santo',
#	Date.civil(2016,3,25) => 'Viernes Santo',
#	Date.civil(2016,3,27) => 'Pascua',
#	Date.civil(2016,5,1) => 'Día del Trabajador',
#	Date.civil(2016,5,8) => 'Día de la Madre',
#	Date.civil(2016,6,7) => 'Día de la Bandera',
#	Date.civil(2016,6,19) => 'Día del Padre',
#	Date.civil(2016,6,29) => 'San Pablo y San Pedro',
#	Date.civil(2016,7,28) => 'Primer Día de la Independencia',
#	Date.civil(2016,7,29) => 'Segundo Día de la Independencia',
#	Date.civil(2016,8,30) => 'Santa Rosa de Lima',
#	Date.civil(2016,9,24) => 'Día de las Fuerzas Armadas',
#	Date.civil(2016,10,8) => 'Batalla de Angamos',
#	Date.civil(2016,11,1) => 'Todos los Santos',
#	Date.civil(2016,12,8) => 'Inmaculada Concepción',
#	Date.civil(2016,12,25) => 'Navidad del Señor'
#}.each do |date, name|
#	print_tests(name, date, ["pe"], ["informal"])
#end

# nz
#{
#	Date.civil(2007,1,1) => 'New Year\'s Day',
#	Date.civil(2007,1,2) => 'Day after New Year\'s Day',
#	Date.civil(2007,2,6) => 'Waitangi Day',
#	Date.civil(2007,4,6) => 'Good Friday',
#	Date.civil(2007,4,9) => 'Easter Monday',
#	Date.civil(2007,4,25) => 'ANZAC Day',
#	Date.civil(2007,12,25) => 'Christmas Day',
#	Date.civil(2007,12,26) => 'Boxing Day'
#}.each do |date, name|
#	print_tests(name, date, ["nz"], ["informal"])
#end
#
#print_tests("ANZAC Day", Date.civil(2015, 4, 25), ["nz"])
#print_tests("ANZAC Day", Date.civil(2015, 4, 27), ["nz"], ["observed"])
#print_tests("ANZAC Day", Date.civil(2016, 4, 25), ["nz"])
#print_tests("ANZAC Day", Date.civil(2016, 4, 25), ["nz"], ["observed"])
#
#print_tests("Waitangi Day", Date.civil(2015, 2, 6), ["nz"])
#print_tests("Waitangi Day", Date.civil(2015, 2, 6), ["nz"], ["observed"])
#print_tests("Waitangi Day", Date.civil(2016, 2, 6), ["nz"])
#print_tests("Waitangi Day", Date.civil(2016, 2, 8), ["nz"], ["observed"])
#
#print_tests("Nelson Anniversary Day", Date.civil(2016, 2, 1), ["nz_ne"], ["observed"])
#print_tests("Nelson Anniversary Day", Date.civil(2017, 1, 30), ["nz_ne"], ["observed"])
#print_tests("Nelson Anniversary Day", Date.civil(2018, 1, 29), ["nz_ne"], ["observed"])
#print_tests("Nelson Anniversary Day", Date.civil(2019, 2, 4), ["nz_ne"], ["observed"])
#
#
#print_tests("Taranaki Anniversary Day", Date.civil(2016, 3, 14), ["nz_ta"], ["observed"])
#print_tests("Taranaki Anniversary Day", Date.civil(2017, 3, 13), ["nz_ta"], ["observed"])
#print_tests("Taranaki Anniversary Day", Date.civil(2018, 3, 12), ["nz_ta"], ["observed"])
#print_tests("Taranaki Anniversary Day", Date.civil(2019, 3, 11), ["nz_ta"], ["observed"])

# nyse
#{
#	Date.civil(2008,1,1) => 'New Year\'s Day',
#	Date.civil(2008,1,21) => 'Martin Luther King, Jr. Day',
#	Date.civil(2008,2,18) => 'Presidents\' Day',
#	Date.civil(2008,3,21) => 'Good Friday',
#	Date.civil(2008,5,26) => 'Memorial Day',
#	Date.civil(2008,7,4) => 'Independence Day',
#	Date.civil(2008,9,1) => 'Labor Day',
#	Date.civil(2008,11,27) => 'Thanksgiving',
#	Date.civil(2008,12,25) => 'Christmas Day'
#}.each do |date, name|
#	print_tests(name, date, ["nyse"])
#end

# north_america_informal - these tests don't cover the CA component at all...
#{
#	Date.civil(2013,2,2) => 'Groundhog Day',
#	Date.civil(2013,2,14) => 'Valentine\'s Day',
#	Date.civil(2013,3,17) => 'St. Patrick\'s Day',
#	Date.civil(2013,4,1) => 'April Fool\'s Day',
#	Date.civil(2013,4,22) => 'Earth Day',
#	Date.civil(2013,5,12) => 'Mother\'s Day',
#	Date.civil(2013,5,18) => 'Armed Forces Day',
#	Date.civil(2013,6,16) => 'Father\'s Day',
#	Date.civil(2013,10,31) => 'Halloween'
#}.each do |date, name|
#  print_tests(name, date, ["us"], ["informal"])
#end

# no
#{
#	Date.civil(2010,1,1) => 'Nyttårsdag',
#	Date.civil(2010,5,1) => '1. mai',
#	Date.civil(2010,5,17) => '17. mai',
#	Date.civil(2010,12,24) => 'Julaften',
#	Date.civil(2010,12,25) => '1. juledag',
#	Date.civil(2010,12,26) => '2. juledag',
#	Date.civil(2010,12,31) => 'Nyttårsaften',
#	Date.civil(2010,2,14) => 'Fastelavn',
#	Date.civil(2010,3,28) => 'Palmesøndag',
#	Date.civil(2010,4,1) => 'Skjærtorsdag',
#	Date.civil(2010,4,2) => 'Langfredag',
#	Date.civil(2010,4,4) => '1. påskedag',
#	Date.civil(2010,4,5) => '2. påskedag',
#	Date.civil(2010,5,13) => 'Kristi Himmelfartsdag',
#	Date.civil(2010,5,23) => '1. pinsedag',
#	Date.civil(2010,5,24) => '2. pinsedag'
#}.each do |date, name|
#  print_tests(name, date, ["no"], ["informal"])
#end

# nl
#{
#	Date.civil(2008,1,1) => 'Nieuwjaarsdag',
#	Date.civil(2008,3,21) => 'Goede Vrijdag',
#	Date.civil(2008,3,23) => 'Eerste Paasdag',
#	Date.civil(2008,3,24) => 'Tweede Paasdag',
#	Date.civil(2008,4,27) => 'Koningsdag',
#	Date.civil(2008,5,1) => 'Hemelvaartsdag', # Ascension, Easter+39
#	Date.civil(2008,5,5) => 'Bevrijdingsdag',
#	Date.civil(2008,5,11) => 'Eerste Pinksterdag', # Pentecost, Easter+49
#	Date.civil(2008,5,12) => 'Tweede Pinksterdag', # Pentecost, Easter+50
#	Date.civil(2008,12,25) => 'Eerste Kerstdag',
#	Date.civil(2008,12,26) => 'Tweede Kerstdag'
#}.each do |date, name|
#  print_tests(name, date, ["nl"], ["informal"])
#end

# nerc
#{
#	Date.civil(2013,1,1) => 'New Year\'s Day',
#	Date.civil(2017,1,2) => 'New Year\'s Day',
#	Date.civil(2013,5,27) => 'Memorial Day',
#	Date.civil(2013,7,4) => 'Independence Day',
#	Date.civil(2010,7,5) => 'Independence Day',
#	Date.civil(2013,9,2) => 'Labor Day',
#	Date.civil(2013,11,28) => 'Thanksgiving',
#	Date.civil(2013,12,25) => 'Christmas Day',
#	Date.civil(2011,12,26) => 'Christmas Day'
#}.each do |date, name|
#  print_tests(name, date, ["nerc"], ["observed"])
#end

# my
#{
#	Date.civil(2016,1,1) => "New Year's Day",
#	Date.civil(2016,5,1) => 'Labour Day',
#	Date.civil(2016,6,4) => "Agong's Birthday",
#	Date.civil(2016,8,31) => 'Independence Day',
#	Date.civil(2016,9,16) => 'Malaysia Day',
#	Date.civil(2016,12,25) => 'Christmas Day'
#}.each do |date, name|
#  print_tests(name, date, ["my"], ["informal"])
#end

# mx
#{
#	Date.civil(2007,1,1) => 'Año nuevo',
#	Date.civil(2007,2,5) => 'Día de la Constitución',
#	Date.civil(2007,5,1) => 'Día del Trabajo',
#	Date.civil(2007,5,5) => 'Cinco de Mayo',
#	Date.civil(2007,9,16) => 'Día de la Independencia',
#	Date.civil(2007,11,1) => 'Todos los Santos',
#	Date.civil(2007,11,2) => 'Los Fieles Difuntos',
#	Date.civil(2007,11,19) => 'Día de la Revolución',
#	Date.civil(2007,12,25) => 'Navidad'
#}.each do |date, name|
#  print_tests(name, date, ["mx"], ["informal"])
#end

# ra
#{
#	Date.civil(2007,1,1) => 'Ras l\' âm',
#	Date.civil(2007,1,11) => 'Takdim watikat al-istiqlal',
#	Date.civil(2007,5,1) => 'Eid Ash-Shughl',
#	Date.civil(2007,7,30) => 'Eid Al-Ârch',
#	Date.civil(2007,8,14) => 'Zikra Oued Ed-Dahab',
#	Date.civil(2007,8,20) => 'Thawrat al malik wa shâab',
#	Date.civil(2007,8,21) => 'Eid Al Milad',
#	Date.civil(2007,11,6) => 'Eid Al Massira Al Khadra',
#	Date.civil(2007,11,18) => 'Eid Al Istiqulal'
#}.each do |date, name|
#  print_tests(name, date, ["ma"], ["informal"])
#end

# lu
#{
#  Date.civil(2008,1,1) => 'Neijoerschdag',
#  Date.civil(2008,3,24) => 'Ouschterméindeg',
#  Date.civil(2008,5,1) => 'Christi Himmelfaart', # Ascension, Easter+39
#  Date.civil(2008,6,23) => 'Nationalfeierdag',
#  Date.civil(2008,8,15) => 'Léiffrawëschdag',
#  Date.civil(2008,11,1) => 'Allerhellgen',
#  Date.civil(2008,12,25) => 'Chrëschtdag',
#  Date.civil(2008,12,26) => 'Stiefesdag',
#  Date.civil(2008,5,11) => 'Péngschtméindeg'
#}.each do |date, name|
#  print_tests(name, date, ["lu"], ["informal"])
#end

# lt
#{
#	Date.civil(2008,1,1) => 'Naujieji metai',
#	Date.civil(2008,2,16) => 'Valstybės atkūrimo diena',
#	Date.civil(2008,3,11) => 'Nepriklausomybės atkūrimo diena',
#	Date.civil(2008,3,23) => 'Šv. Velykos',
#	Date.civil(2008,3,24) => 'Antroji Velykų diena',
#	Date.civil(2008,5,1) => 'Darbininkų diena',
#	Date.civil(2008,6,24) => 'Joninės',
#	Date.civil(2008,7,6) => 'Valstybės diena',
#	Date.civil(2008,8,15) => 'Žolinė',
#	Date.civil(2008,11,1) => 'Visų šventųjų diena',
#	Date.civil(2008,12,24) => 'Šv. Kūčios',
#	Date.civil(2008,12,25) => 'Šv. Kalėdos',
#	Date.civil(2008,12,26) => 'Antroji Kalėdų diena'
#}.each do |date, name|
#  print_tests(name, date, ["lt"])
#end

#{
#	Date.civil(2012,1,1) => 'Naujieji metai',
#	Date.civil(2012,2,16) => 'Valstybės atkūrimo diena',
#	Date.civil(2012,3,11) => 'Nepriklausomybės atkūrimo diena',
#	Date.civil(2012,4,8) => 'Šv. Velykos',
#	Date.civil(2012,4,9) => 'Antroji Velykų diena',
#	Date.civil(2012,5,1) => 'Darbininkų diena',
#	Date.civil(2012,6,24) => 'Joninės',
#	Date.civil(2012,7,6) => 'Valstybės diena',
#	Date.civil(2012,8,15) => 'Žolinė',
#	Date.civil(2012,11,1) => 'Visų šventųjų diena',
#	Date.civil(2012,12,24) => 'Šv. Kūčios',
#	Date.civil(2012,12,25) => 'Šv. Kalėdos',
#	Date.civil(2012,12,26) => 'Antroji Kalėdų diena'
#}.each do |date, name|
#  print_tests(name, date, ["lt"])
#end

# li
#{
#	Date.civil(2009,1,1) => 'Neujahrstag',
#	Date.civil(2011,3,8) => 'Fasnachtsdienstag',
#	Date.civil(2009,4,10) => 'Karfreitag',
#	Date.civil(2009,4,12) => 'Ostern',
#	Date.civil(2009,4,13) => 'Ostermontag',
#	Date.civil(2009,5,21) => 'Auffahrt',
#	Date.civil(2009,6,1) => 'Pfingstmontag',
#	Date.civil(2009,12,25) => 'Weihnachten',
#	Date.civil(2009,12,26) => 'Stefanstag'
#}.each do |date, name|
#  print_tests(name, date, ["li"], ["informal"])
#end
#
#[:li].each do |r|
#  print_tests('Fronleichnam', Date.civil(2009, 6, 11), ["li"])
#end
#
#[:li].each do |r|
#  print_tests('Staatsfeiertag', Date.civil(2009, 8, 15), ["li"])
#end
#
#[:li].each do |r|
#  print_tests('Allerheiligen', Date.civil(2009, 11, 1), ["li"])
#end
#
#
# kr
#{
#	Date.civil(2016,2,8) => "Korean New Year",
#	Date.civil(2016,5,14) => "Buddah\'s Birthday",
#	Date.civil(2016,9,12) => "Korean Thanksgiving",
#	Date.civil(2016,1,1) => "New Year\'s Day",
#	Date.civil(2016,3,1) => "Independence Movement Day",
#	Date.civil(2016,5,5) => "Children\'s Day",
#	Date.civil(2016,6,6) => "Memorial Day",
#	Date.civil(2016,7,17) => "Constitution Day",
#	Date.civil(2016,8,15) => "Liberation Day",
#	Date.civil(2016,10,3) => "National Foundation Day",
#	Date.civil(2016,10,9) => "Hangul Day",
#	Date.civil(2016,12,25) => "Christmas Day"
#}.each do |date, name|
#  print_tests(name, date, ["kr"], ["informal"])
#end
#
# jp
#{
#	Date.civil(2008,1,1) => '元日',
#	Date.civil(2010,1,11) => '成人の日',
#	Date.civil(2008,2,11) => '建国記念の日',
#	Date.civil(2008,4,29) => '昭和の日',
#	Date.civil(2008,5,3) => '憲法記念日',
#	Date.civil(2008,5,5) => 'こどもの日',
#	Date.civil(2010,7,19) => '海の日',
#	Date.civil(2010,9,20) => '敬老の日',
#	Date.civil(2010,10,11) => '体育の日',
#	Date.civil(2008,11,3) => '文化の日',
#	Date.civil(2008,11,23) => '勤労感謝の日',
#	Date.civil(2008,12,23) => '天皇誕生日',
#	Date.civil(2010,3,22) => '振替休日',
#	Date.civil(2008,11,24) => '振替休日',
#	Date.civil(2012,1,2) => '振替休日',
#	Date.civil(2013,5,6) => '振替休日',
#	Date.civil(2014,5,6) => '振替休日',
#	Date.civil(2015,5,6) => '振替休日',
#	Date.civil(2019,8,12) => '振替休日'
#}.each do |date, name|
#  print_tests(name, date, ["jp"], ["informal"])
#end
#
## vernal equinox day
#[
#	Date.civil(2004,3,20), Date.civil(2005,3,20), Date.civil(2006,3,21),
#	Date.civil(2007,3,21), Date.civil(2008,3,20), Date.civil(2009,3,20),
#	Date.civil(2010,3,21)
#].each do |date|
#  print_tests('春分の日', date, ["jp"])
#end
#
## national culture day
#[
#	Date.civil(2004,9,23), Date.civil(2005,9,23), Date.civil(2006,9,23),
#	Date.civil(2007,9,23), Date.civil(2008,9,23), Date.civil(2009,9,23),
#	Date.civil(2010,9,23), Date.civil(2011,9,23), Date.civil(2012,9,22),
#	Date.civil(2013,9,23)
#].each do |date|
#  print_tests('秋分の日', date, ["jp"])
#end
#
## citizens holiday
#[
#	Date.civil(2032,9,21), Date.civil(2049,9,21), Date.civil(2009,9,22),
#	Date.civil(2015,9,22), Date.civil(2026,9,22)
#].each do |date|
#  print_tests('国民の休日', date, ["jp"])
#end
#
## marine day since 1996
#[
#	Date.civil(1996, 7, 20), Date.civil(2002, 7, 20), Date.civil(2003, 7, 21),
#	Date.civil(2004, 7, 19), Date.civil(2005, 7, 18), Date.civil(2006, 7, 17),
#	Date.civil(2007, 7, 16), Date.civil(2009, 7, 20), Date.civil(2013, 7, 15),
#	Date.civil(2014, 7, 21)
#].each do |date|
#  print_tests('海の日', date, ["jp"])
#end
#
## mountain holiday start since 2016
#[
#	Date.civil(2016,8,11), Date.civil(2017,8,11),Date.civil(2018,8,11),
#	Date.civil(2019,8,11), Date.civil(2020,8,11),Date.civil(2021,8,11),
#	Date.civil(2022,8,11)
#].each do |date|
#  print_tests('山の日', date, ["jp"])
#end
#
## before 2016, there is no mountain holiday.
#print_tests('Not a holiday', Date.civil(2015, 8, 11), ["jp"])
#
## before 2003, there is no citizens holiday.
## [note] citizens holiday requires that jp_national_culture_day is wednesday.
##        Before 2003, the closest past year that mathches above condition is 1998.
#print_tests('Not a holiday', Date.civil(1998, 9, 22), ["jp"])
#
# it
#{
#	Date.civil(2007,1,1) => 'Capodanno',
#	Date.civil(2007,1,6) => 'Epifania',
#	Date.civil(2007,4,8) => 'Pasqua',
#	Date.civil(2007,4,9) => 'Lunedì dell\'Angelo',
#	Date.civil(2007,4,25) => 'Festa della Liberazione',
#	Date.civil(2007,5,1) => 'Festa dei Lavoratori',
#	Date.civil(2007,6,2) => 'Festa della Repubblica',
#	Date.civil(2007,8,15) => 'Assunzione',
#	Date.civil(2007,11,1) => 'Ognissanti',
#	Date.civil(2007,12,8) => 'Immacolata Concezione',
#	Date.civil(2007,12,25) => 'Natale',
#	Date.civil(2007,12,26) => 'Santo Stefano'
#}.each do |date, name|
#  print_tests(name, date, ["it"], ["informal"])
#end

# is
#{
#	Date.civil(2007,1,1) => 'Nýársdagur',
#	Date.civil(2007,1,6) => 'Þrettándinn',
#	Date.civil(2007,1,19) => 'Bóndadagur',
#	Date.civil(2007,2,18) => 'Konudagur',
#	Date.civil(2007,4,5) => 'Skírdagur',
#	Date.civil(2007,4,6) => 'Föstudaginn langi',
#	Date.civil(2007,4,8) => 'Páskadagur',
#	Date.civil(2007,4,9) => 'Annar í páskum',
#	Date.civil(2007,4,19) => 'Sumardagurinn fyrsti',
#	Date.civil(2007,5,1) => 'Verkalýðsdagurinn',
#	Date.civil(2007,5,17) => 'Uppstigningardagur',
#	Date.civil(2007,5,27) => 'Hvítasunnudagur',
#	Date.civil(2007,5,28) => 'Annar í hvítasunnu',
#	Date.civil(2007,6,3) => 'Sjómannadagurinn',
#	Date.civil(2007,6,17) => 'Lýðveldisdagurinn',
#	Date.civil(2007,8,6) => 'Frídagur verslunarmanna',
#	Date.civil(2007,12,24) => 'Jól',
#	Date.civil(2007,12,25) => 'Jól',
#	Date.civil(2007,12,26) => 'Jól',
#	Date.civil(2007,12,31) => 'Gamlárskvöld'
#}.each do |date, name|
#  print_tests(name, date, ["is"], ["informal"])
#end
#
# ie
#{
#	Date.civil(2008,1,1) => 'New Year\'s Day',
#	Date.civil(2008,3,17) => 'St. Patrick\'s Day',
#	Date.civil(2008,3,24) => 'Easter Monday',
#	Date.civil(2008,5,5) => 'May Day',
#	Date.civil(2008,6,2) => 'June Bank Holiday',
#	Date.civil(2008,8,4) => 'August Bank Holiday',
#	Date.civil(2008,10,27) => 'October Bank Holiday',
#	Date.civil(2008,12,25) => 'Christmas Day',
#	Date.civil(2008,12,26) => 'St. Stephen\'s Day'
#}.each do |date, name|
#  print_tests(name, date, ["ie"])
#end
#
#{
#	Date.civil(2012,1,2) => 'New Year\'s Day',
#	Date.civil(2012,3,19) => 'St. Patrick\'s Day',
#	Date.civil(2012,4,9) => 'Easter Monday',
#	Date.civil(2012,5,7) => 'May Day',
#	Date.civil(2012,6,4) => 'June Bank Holiday',
#	Date.civil(2012,8,6) => 'August Bank Holiday',
#	Date.civil(2012,10,29) => 'October Bank Holiday',
#	Date.civil(2011,12,26) => 'Christmas Day',
#	Date.civil(2011,12,27) => 'St. Stephen\'s Day',
#	Date.civil(2012,12,25) => 'Christmas Day',
#	Date.civil(2012,12,26) => 'St. Stephen\'s Day',
#	Date.civil(2015,12,28) => 'St. Stephen\'s Day'
#}.each do |date, name|
#  print_tests(name, date, ["ie"], ["observed"])
#end
#
# hu
#{
#	Date.civil(2012,1,1) => 'Újév',
#	Date.civil(2011,1,1) => 'Újév',
#	Date.civil(2012,3,15) => '1848/49-es forradalom és szabadságharc ünnepe',
#	Date.civil(2011,4,25) => 'Húsvét hétfő',
#	Date.civil(2012,4,9) => 'Húsvét hétfő',
#	Date.civil(2012,5,1) => 'A munka ünnepe',
#	Date.civil(2011,6,13) => 'Pünkösd hétfő',
#	Date.civil(2012,5,28) => 'Pünkösd hétfő',
#	Date.civil(2012,8,20) => 'Az államalapítás ünnepe',
#	Date.civil(2012,10,23) => '1956-os forradalom és szabadságharc ünnepe',
#	Date.civil(2012,11,1) => 'Mindenszentek',
#	Date.civil(2012,12,25) => 'Karácsony',
#	Date.civil(2012,12,26) => 'Karácsony',
#}.each do |date, name|
#  print_tests(name, date, ["hu"], ["informal"])
#end
#
#print_tests('Not a holiday', Date.civil(2012, 3, 14), ["hu"])
#
# hr
#{
#	Date.civil(2012,1,1) => 'Nova godina',
#	Date.civil(2012,1,6) => 'Sveta tri kralja',
#	Date.civil(2012,5,1) => 'Međunarodni praznik rada',
#	Date.civil(2012,6,22) => 'Dan antifašističke borbe',
#	Date.civil(2012,6,25) => 'Dan državnosti',
#	Date.civil(2012,8,5) => 'Dan pobjede i domovinske zahvalnosti i dan hrvatskih branitelja',
#	Date.civil(2012,8,15) => 'Velika Gospa',
#	Date.civil(2012,10,8) => 'Dan neovisnosti',
#	Date.civil(2012,11,1) => 'Dan svih svetih',
#	Date.civil(2012,12,25) => 'Božić',
#	Date.civil(2012,12,26) => 'Sveti Stjepan'
#}.each do |date, name|
#  print_tests(name, date, ["hr"], ["informal"])
#end
#
## Tijelovo
#[
#	Date.civil(2008,5,22), Date.civil(2009,6,11), Date.civil(2010,6,3),
#	Date.civil(2012,6,7), Date.civil(2013,5,30), Date.civil(2014,6,19)
#].each do |date|
#  print_tests('Tijelovo', date, ["hr"])
#end

# hk
#{
#	Date.civil(2016,1,1) => 'New Year\'s Day',
#	Date.civil(2016,2,8) => 'Lunar New Year\'s Day',
#	Date.civil(2016,2,9) => 'The second day of Lunar New Year',
#	Date.civil(2016,2,10) => 'The third day of Lunar New Year',
#	Date.civil(2016,3,25) => 'Good Friday',
#	Date.civil(2016,3,26) => 'The day following Good Friday',
#	Date.civil(2016,3,28) => 'Easter Monday',
#	Date.civil(2016,5,2) => 'Labour Day',
#	Date.civil(2016,7,1) => 'Hong Kong Special Administrative Region Establishment Day',
#	Date.civil(2016,10,1) => 'National Day',
#	Date.civil(2016,12,26) => 'Christmas Day',
#	Date.civil(2016,12,27) => 'Boxing Day',
#	Date.civil(2017,1,2) => 'New Year\'s Day',
#	Date.civil(2017,1,28) => 'Lunar New Year\'s Day',
#	Date.civil(2017,1,30) => 'The second day of Lunar New Year',
#	Date.civil(2017,1,31) => 'The third day of Lunar New Year',
#	Date.civil(2017,4,14) => 'Good Friday',
#	Date.civil(2017,4,15) => 'The day following Good Friday',
#	Date.civil(2017,4,17) => 'Easter Monday',
#	Date.civil(2017,5,1) => 'Labour Day',
#	Date.civil(2017,7,1) => 'Hong Kong Special Administrative Region Establishment Day',
#	Date.civil(2017,10,2) => 'National Day',
#	Date.civil(2017,12,25) => 'Christmas Day',
#	Date.civil(2017,12,26) => 'Boxing Day'
#}.each do |date, name|
#  print_tests(name, date, ["hk"], ["observed"])
#end

# gb
#{
#  Date.civil(2008,3,21) => 'Good Friday',
#  Date.civil(2008,3,23) => 'Easter Sunday',
#  Date.civil(2008,5,5) => 'May Day',
#  Date.civil(2008,5,26) => 'Bank Holiday',
#  Date.civil(2008,11,5) => 'Guy Fawkes Day',
#  Date.civil(2008,12,25) => 'Christmas Day',
#  Date.civil(2008,12,26) => 'Boxing Day'
#}.each do |date, name|
#  print_tests(name, date, ["gb"], ["informal"])
#end
#
#print_tests('St. Patrick\'s Day', Date.civil(2008, 3, 17), ["gb_nir"], ["informal"])
#
## St. Andrew's Day is informal 2006 and earlier. Should only show up when :informal is passed
#print_tests('St. Andrew\'s Day', Date.civil(2006, 11, 30), ["gb_sct"], ["informal"])
#print_tests('St. Andrew\'s Day', Date.civil(2006, 11, 30), ["gb_sct"], ["informal", "observed"])
#print_tests('St. Andrew\'s Day', Date.civil(2002, 12, 2), ["gb_sct"], ["informal", "observed"])
#print_tests('Not a holiday', Date.civil(2004, 11, 30), ["gb_sct"])
#print_tests('Not a holiday', Date.civil(2005, 11, 30), ["gb_sct"])
#print_tests('Not a holiday', Date.civil(2006, 11, 30), ["gb_sct"])
#
## St. Andrew's Day is considered a formal bank holiday 2007 and later. It should show up regardless of whether
## :informal is specified
#print_tests('St. Andrew\'s Day', Date.civil(2007, 11, 30), ["gb_sct"])
#print_tests('St. Andrew\'s Day', Date.civil(2007, 11, 30), ["gb_sct"], ["informal"])
#print_tests('St. Andrew\'s Day', Date.civil(2007, 11, 30), ["gb_sct"], ["informal", "observed"])
#
#print_tests('St. Andrew\'s Day', Date.civil(2016, 11, 30), ["gb_sct"])
#print_tests('St. Andrew\'s Day', Date.civil(2019, 11, 30), ["gb_sct"])
#print_tests('St. Andrew\'s Day', Date.civil(2019, 11, 30), ["gb_sct"], ["observed"])
#
#print_tests('Christmas Day', Date.civil(2008, 12, 25), ["gb_"], ["observed"])
#print_tests('Christmas Day', Date.civil(2009, 12, 25), ["gb_"], ["observed"])
#print_tests('Christmas Day', Date.civil(2010, 12, 27), ["gb_"], ["observed"])
#
#print_tests('Boxing Day', Date.civil(2008, 12, 26), ["gb_"], ["observed"])
#print_tests('Boxing Day', Date.civil(2009, 12, 28), ["gb_"], ["observed"])
#print_tests('Boxing Day', Date.civil(2010, 12, 28), ["gb_"], ["observed"])
#print_tests('Boxing Day', Date.civil(2011, 12, 27), ["gb_"], ["observed"])
#
#print_tests('New Year\'s Day', Date.civil(2010, 1, 1), ["gb"], ["observed"])
#print_tests('New Year\'s Day', Date.civil(2011, 1, 3), ["gb"], ["observed"])
#print_tests('New Year\'s Day', Date.civil(2012, 1, 2), ["gb"], ["observed"])
#
#print_tests('2nd January', Date.civil(2010, 1, 4), ["gb_sct"], ["observed"])
#print_tests('2nd January', Date.civil(2011, 1, 4), ["gb_sct"], ["observed"])
#print_tests('2nd January', Date.civil(2012, 1, 3), ["gb_sct"], ["observed"])
#print_tests('2nd January', Date.civil(2013, 1, 2), ["gb_sct"], ["observed"])
#print_tests('2nd January', Date.civil(2014, 1, 2), ["gb_sct"], ["observed"])
#
#[:gb_wls, :gb_eng, :gb_nir, :gb_eaw, :gb_].each do |r|
#  print_tests('Easter Monday', Date.civil(2008, 3, 24), [r.to_s])
#  print_tests('Bank Holiday', Date.civil(2008, 8, 25), [r.to_s])
#end

#fr
#{
#	Date.civil(2007,1,1) => 'Jour de l\'an',
#	Date.civil(2007,4,9) => 'Lundi de Pâques',
#	Date.civil(2007,5,1) => 'Fête du travail',
#	Date.civil(2007,5,8) => 'Victoire 1945',
#	Date.civil(2007,5,17) => 'Ascension',
#	Date.civil(2007,5,28) => 'Lundi de Pentecôte',
#	Date.civil(2007,7,14) => 'Fête nationale',
#	Date.civil(2007,8,15) => 'Assomption',
#	Date.civil(2007,11,1) => 'Toussaint',
#	Date.civil(2007,11,11) => 'Armistice 1918',
#	Date.civil(2007,12,25) => 'Noël'
#}.each do |date, name|
#  print_tests(name, date, ["fr"])
#end
#
#{
#	Date.civil(2007,4,8) => 'Pâques',
#	Date.civil(2007,5,27) => 'Pentecôte'
#}.each do |date, name|
#	#assert_nil (Holidays.on(date, :fr)[0] || {})[:name]
#  print_tests(name, date, ["fr"], ["informal"])
#end
#
# fi
#{
#	Date.civil(2008,1,1) => 'Uudenvuodenpäivä',
#	Date.civil(2008,1,6) => 'Loppiainen',
#	Date.civil(2008,3,21) => 'Pitkäperjantai',
#	Date.civil(2008,3,23) => 'Pääsiäispäivä',
#	Date.civil(2008,3,24) => '2. Pääsiäispäivä',
#	Date.civil(2008,5,1) => 'Vappu',
#	Date.civil(2008,5,1) => 'Helatorstai',
#	Date.civil(2008,5,11) => 'Helluntaipäivä',
#	Date.civil(2009,6,19) => 'Juhannusaatto',
#	Date.civil(2010,6,25) => 'Juhannusaatto',
#	Date.civil(2011,6,24) => 'Juhannusaatto',
#	Date.civil(2012,6,22) => 'Juhannusaatto',
#	Date.civil(2013,6,21) => 'Juhannusaatto',
#	Date.civil(2005,6,25) => 'Juhannuspäivä',
#	Date.civil(2006,6,24) => 'Juhannuspäivä',
#	Date.civil(2007,6,23) => 'Juhannuspäivä',
#	Date.civil(2008,6,21) => 'Juhannuspäivä',
#	Date.civil(2005,11,5) => 'Pyhäinpäivä',
#	Date.civil(2006,11,4) => 'Pyhäinpäivä',
#	Date.civil(2007,11,3) => 'Pyhäinpäivä',
#	Date.civil(2008,11,1) => 'Pyhäinpäivä',
#	Date.civil(2008,12,6) => 'Itsenäisyyspäivä',
#	Date.civil(2008,12,24) => 'Jouluaatto',
#	Date.civil(2008,12,25) => 'Joulupäivä',
#	Date.civil(2008,12,26) => 'Tapaninpäivä'
#}.each do |date, name|
#  print_tests(name, date, ["fi"], ["informal"])
#end

# fedex
#{
#	Date.civil(2015,1,1) => 'New Year\'s Day',
#	Date.civil(2015,5,25) => 'Memorial Day',
#	Date.civil(2015,7,4) => 'Independence Day',
#	Date.civil(2015,9,7) => 'Labor Day',
#	Date.civil(2015,11,26) => 'Thanksgiving',
#	Date.civil(2015,11,27) => 'Day After Thanksgiving',
#	Date.civil(2013,11,28) => 'Thanksgiving',
#	Date.civil(2013,11,29) => 'Day After Thanksgiving',
#	Date.civil(2015,12,25) => 'Christmas Day',
#	Date.civil(2015,12,31) => 'New Year\'s Eve',
#}.each do |date, name|
#  print_tests(name, date, ["ups"])
#end

# federal_reserve
#{
#	Date.civil(2012,1,2) => "New Year's Day",
#	Date.civil(2012,1,16) => "Birthday of Martin Luther King, Jr",
#	Date.civil(2012,2,20) => "Washington's Birthday",
#	Date.civil(2012,5,28) => "Memorial Day",
#	Date.civil(2012,7,4) => "Independence Day",
#	Date.civil(2012,9,3) => "Labor Day",
#	Date.civil(2012,10,8) => "Columbus Day",
#	Date.civil(2012,11,12) => "Veterans Day",
#	Date.civil(2012,11,22) => "Thanksgiving Day",
#	Date.civil(2012,12,25) => "Christmas Day",
#
#	Date.civil(2013,1,1) => "New Year's Day",
#	Date.civil(2013,1,21) => "Birthday of Martin Luther King, Jr",
#	Date.civil(2013,2,18) => "Washington's Birthday",
#	Date.civil(2013,5,27) => "Memorial Day",
#	Date.civil(2013,7,4) => "Independence Day",
#	Date.civil(2013,9,2) => "Labor Day",
#	Date.civil(2013,10,14) => "Columbus Day",
#	Date.civil(2013,11,11) => "Veterans Day",
#	Date.civil(2013,11,28) => "Thanksgiving Day",
#	Date.civil(2013,12,25) => "Christmas Day",
#
#	Date.civil(2014,1,1) => "New Year's Day",
#	Date.civil(2014,1,20) => "Birthday of Martin Luther King, Jr",
#	Date.civil(2014,2,17) => "Washington's Birthday",
#	Date.civil(2014,5,26) => "Memorial Day",
#	Date.civil(2014,7,4) => "Independence Day",
#	Date.civil(2014,9,1) => "Labor Day",
#	Date.civil(2014,10,13) => "Columbus Day",
#	Date.civil(2014,11,11) => "Veterans Day",
#	Date.civil(2014,11,27) => "Thanksgiving Day",
#	Date.civil(2014,12,25) => "Christmas Day",
#
#	Date.civil(2015,1,1) => "New Year's Day",
#	Date.civil(2015,1,19) => "Birthday of Martin Luther King, Jr",
#	Date.civil(2015,2,16) => "Washington's Birthday",
#	Date.civil(2015,5,25) => "Memorial Day",
#	Date.civil(2015,7,4) => "Independence Day",
#	Date.civil(2015,9,7) => "Labor Day",
#	Date.civil(2015,10,12) => "Columbus Day",
#	Date.civil(2015,11,11) => "Veterans Day",
#	Date.civil(2015,11,26) => "Thanksgiving Day",
#	Date.civil(2015,12,25) => "Christmas Day",
#
#	Date.civil(2016,1,1) => "New Year's Day",
#	Date.civil(2016,1,18) => "Birthday of Martin Luther King, Jr",
#	Date.civil(2016,2,15) => "Washington's Birthday",
#	Date.civil(2016,5,30) => "Memorial Day",
#	Date.civil(2016,7,4) => "Independence Day",
#	Date.civil(2016,9,5) => "Labor Day",
#	Date.civil(2016,10,10) => "Columbus Day",
#	Date.civil(2016,11,11) => "Veterans Day",
#	Date.civil(2016,11,24) => "Thanksgiving Day",
#	Date.civil(2016,12,26) => "Christmas Day",
#}.each do |date, name|
#  print_tests(name, date, ["federal_reserve"], ["observed"])
#end

 # es
#{
#  Date.civil(2009,1,1) => 'Año Nuevo',
#  Date.civil(2009,1,6) => 'Día de Reyes',
#  Date.civil(2009,4,10) => 'Viernes Santo',
#  Date.civil(2009,5,1) => 'Día del Trabajador',
#  Date.civil(2009,8,15) => 'Asunción',
#  Date.civil(2009,10,12) => 'Día de la Hispanidad',
#  Date.civil(2009,11,1) => 'Todos los Santos',
#  Date.civil(2009,12,6) => 'Día de la Constitución',
#  Date.civil(2009,12,8) => 'Inmaculada Concepción',
#  Date.civil(2009,12,25) => 'Navidad del Señor'
#}.each do |date, name|
#  print_tests(name, date, ["es"], ["informal"])
#end
#
#[:es_pv, :es_na, :es_an, :es_ib, :es_cm, :es_mu, :es_m, :es_ar, :es_cl, :es_cn, :es_lo, :es_ga, :es_ce, :es_o, :es_ex, :es_].each do |r|
#  print_tests('Jueves Santo', Date.civil(2009, 4, 9), [r.to_s], ["informal"])
#end
#
#[:es_pv, :es_ct, :es_na, :es_v, :es_vc, :es_].each do |r|
#  print_tests('Lunes de Pascua', Date.civil(2009, 4, 13), [r.to_s])
#end
#
#print_tests('Jueves Santo', Date.civil(2009, 4, 9), ["es_an"])
#
#[:es_v, :es_vc, :es_cm, :es_mu, :es_m, :es_].each do |r|
#  print_tests('San José', Date.civil(2009, 3, 19), [r.to_s])
#end
#
#[:es_cl].each do |r|
#  print_tests('Día de Castilla y León', Date.civil(2009, 4, 23), [r.to_s])
#end
#
#[:es_ar].each do |r|
#  print_tests('San Jorge, Día de Aragón', Date.civil(2009, 4, 23), [r.to_s])
#end
#
#[:es_].each do |r|
#  print_tests('Día de Castilla y León', Date.civil(2009, 4, 23), [r.to_s])
#  print_tests('San Jorge, Día de Aragón', Date.civil(2009, 4, 23), [r.to_s])
#end
#
#[:es_vc, :es_v, :es_].each do |r|
#  print_tests('Día de Valencia', Date.civil(2009, 10, 9), [r.to_s])
#end
#
#[:es_ib, :es_ct, :es_].each do |r|
#  print_tests('San Esteban', Date.civil(2009, 12, 26), [r.to_s])
#end
#
#print_tests('Año Nuevo', Date.civil(2012, 1, 1), ["es"])
#print_tests('Año Nuevo', Date.civil(2012, 1, 2), ["es"], ["observed"])
#print_tests('Día de Andalucía', Date.civil(2009, 2, 28), ["es_an"])
#print_tests('Día de las Islas Baleares', Date.civil(2009, 3, 1), ["es_ib"])
#print_tests('Fiesta de la Comunidad', Date.civil(2006, 5, 2), ["es_m"])
#print_tests('Día de las Canarias', Date.civil(2006, 5, 30), ["es_cn"])
#print_tests('Día de la Región Castilla-La Mancha', Date.civil(2009, 5, 31), ["es_cm"])
#print_tests('Día de la Región de Murcia', Date.civil(2009, 6, 9), ["es_mu"])
#print_tests('Día de La Rioja', Date.civil(2009, 6, 9), ["es_lo"])
#print_tests('Santiago Apostol', Date.civil(2009, 7, 23), ["es_ga"])
#print_tests('Día de Ceuta', Date.civil(2009, 9, 2), ["es_ce"])
#print_tests('Día de Asturias', Date.civil(2009, 9, 8), ["es_o"])
#print_tests('Día de Extremadura', Date.civil(2009, 9, 8), ["es_ex"])
#print_tests('Fiesta Nacional de Cataluña', Date.civil(2009, 9, 11), ["es_ct"])

# cz
#{Date.civil(2010,1,1) => 'Den obnovy samostatného českého státu',
# Date.civil(2016,3,25) => 'Velký pátek',
# Date.civil(2010,4,5) => 'Velikonoční pondělí',
# Date.civil(2010,5,1) => 'Svátek práce',
# Date.civil(2010,5,8) => 'Den vítězství',
# Date.civil(2010,7,5) => 'Den slovanských věrozvěstů Cyrila a Metoděje',
# Date.civil(2010,7,6) => 'Den upálení mistra Jana Husa',
# Date.civil(2010,9,28) => 'Den české státnosti',
# Date.civil(2010,10,28) => 'Den vzniku samostatného československého státu',
# Date.civil(2010,11,17) => 'Den boje za svobodu a demokracii',
# Date.civil(2010,12,24) => 'Štědrý den',
# Date.civil(2010,12,25) => '1. svátek vánoční',
# Date.civil(2010,12,26) => '2. svátek vánoční'}.each do |date, name|
#	 print_tests(name, date, ["cz"], ["informal"])
# end
#
# cr
#{Date.civil(2015,1,1) => 'Año Nuevo',
# Date.civil(2015,4,11) => 'Día de Juan Santamaría',
# Date.civil(2015,5,1) => 'Día del Trabajador',
# Date.civil(2015,7,25) => 'Día de la Anexión de Guanacaste',
# Date.civil(2015,8,2) => 'Día de la Virgen de los Angeles',
# Date.civil(2015,8,15) => 'Día de la Madre',
# Date.civil(2015,9,15) => 'Día de la Independencia',
# Date.civil(2015,10,12) => 'Día de las Culturas',
# Date.civil(2016,12,25) => 'Navidad'}.each do |date, name|
#	 print_tests(name, date, ["cr"])
# end

# cl
#{Date.civil(2014,1,1) => 'Año Nuevo',
# Date.civil(2011,4,22) => 'Viernes Santo',
# Date.civil(2011,4,23) => 'Sábado Santo',
# Date.civil(2012,4,6) => 'Viernes Santo',
# Date.civil(2012,4,7) => 'Sábado Santo',
# Date.civil(2013,3,29) => 'Viernes Santo',
# Date.civil(2013,3,30) => 'Sábado Santo',
# Date.civil(2014,4,18) => 'Viernes Santo',
# Date.civil(2014,4,19) => 'Sábado Santo',
# Date.civil(2015,4,3) => 'Viernes Santo',
# Date.civil(2015,4,4) => 'Sábado Santo',
# Date.civil(2016,3,25) => 'Viernes Santo',
# Date.civil(2016,3,26) => 'Sábado Santo',
# Date.civil(2014,5,1) => 'Día del Trabajo',
# Date.civil(2014,5,21) => "Día de las Glorias Navales",
# Date.civil(2014,6,29) => "San Pedro y San Pablo",
# Date.civil(2014,7,16) => "Día de la Virgen del Carmen",
# Date.civil(2014,8,15) => "Asunción de la Virgen",
# Date.civil(2014,9,18) => "Independencia Nacional",
# Date.civil(2014,9,19) => "Día de las Glorias del Ejército",
# Date.civil(2014,10,12) => "Encuentro de Dos Mundos",
# Date.civil(2014,10,31) => "Día de las Iglesias Evangélicas y Protestantes",
# Date.civil(2014,11,1) => "Día de Todos los Santos",
# Date.civil(2014,12,8) => 'Inmaculada Concepción de María',
# Date.civil(2014,12,25) => 'Navidad'}.each do |date, name|
#	 print_tests(name, date, ["cl"], ["informal"])
# end

# ch
#{ Date.civil(2012,8,1) => 'Bundesfeiertag',
#	Date.civil(2012,12,25) => 'Weihnachten',
#	Date.civil(2012,05,17) => 'Auffahrt'
#}.each do |date, name|
#  print_tests(name, date, ["ch"])
#end
#
#{ Date.civil(2012,8,1) => 'Bundesfeiertag',
#	Date.civil(2012,12,25) => 'Weihnachten',
#	Date.civil(2012,05,17) => 'Auffahrt',
#	Date.civil(2012,5,1) => 'Tag der Arbeit',
#	Date.civil(2012,12,26) => 'Stefanstag'
#}.each do |date, name|
#  print_tests(name, date, ["ch_zh"])
#end
#
#[Date.civil(2012,9,17), Date.civil(2013,9,16), Date.civil(2014,9,22)].each do |date|
#  print_tests("Lundi du Jeûne fédéral", date, ["ch_vd"])
#end
#
#[Date.civil(2012,9,6), Date.civil(2013,9,5), Date.civil(2014,9,11)].each do |date|
#  print_tests("Jeûne genevois", date, ["ch_ge"])
#end
#
#[Date.civil(2012,4,12), Date.civil(2013,4,4), Date.civil(2014,4,3)].each do |date|
#  print_tests("Näfelser Fahrt", date, ["ch_gl"])
#end

# ca - part 19
#[Date.civil(2010, 12, 28), Date.civil(2012, 12, 26), Date.civil(2016, 12, 27),
# Date.civil(2015, 12, 28)].each do |date|
#  print_tests("Boxing Day", date, ["ca"], ["observed"])
#end

# ca - part 18
#[Date.civil(2010, 12, 27), Date.civil(2012, 12, 25), Date.civil(2016, 12, 26)].each do |date|
#  print_tests("Christmas Day", date, ["ca"], ["observed"])
#end

# ca - part 17
#[
#	Date.civil(2010, 11, 11),
#	Date.civil(2012, 11, 12),
#	Date.civil(2017, 11, 13)
#].each do |date|
#  print_tests("Remembrance Day", date, ['ca'], ["observed"])
#end


# ca - part 16
#[
#	Date.civil(2011, 7, 1),
#	Date.civil(2012, 7, 2),
#	Date.civil(2017, 7, 3)
#].each do |date|
#  print_tests("Canada Day", date, ['ca'], ["observed"])
#end

# ca - part 15
#[
#	Date.civil(2011, 1, 3),
#	Date.civil(2012, 1, 2),
#	Date.civil(2016, 1, 1)
#].each do |date|
#  print_tests("New Year's Day", date, ['ca'], ["observed"])
#end

# ca - part 14
#[
#	:ca_ab,
#	:ca_sk,
#	:ca_bc,
#	:ca_pe,
#	:ca_nl,
#	:ca_nt,
#	:ca_nu,
#	:ca_nb,
#	:ca_yt
#].each do |province|
#  print_tests("Remembrance Day", Date.civil(2016, 11, 11), [province.to_s])
#	#assert_equal "Remembrance Day", Holidays.on(Date.civil(2016,11,11), province)[0][:name]
#end

# ca - part 13
#[
#	Date.civil(2013,8,5),
#	Date.civil(2014,8,4),
#	Date.civil(2015,8,3)].each do |date|
#		{
#			:ca_bc => 'BC Day',
#			:ca_sk => 'Saskatchewan Day',
#			:ca_ab => 'Heritage Day',
#			:ca_ns => 'Natal Day',
#			:ca_on => 'Civic Holiday',
#			:ca_nt => 'Civic Holiday',
#			:ca_nu => 'Civic Holiday',
#			:ca_pe => 'Civic Holiday',
#			:ca_nb => 'New Brunswick Day'
#		}.each do |region, name|
#			print_tests(name, date, [region.to_s])
#		end
#	end

# ca - part 12
#[
#	Date.civil(2004,5,24),
#	Date.civil(2005,5,23),
#	Date.civil(2006,5,22),
#	Date.civil(2007,5,21),
#	Date.civil(2008,5,19)
#].each do |date|
#		print_tests('Victoria Day', date, ["ca"])
#	end

# ca - part 11
#[
#	Date.civil(2000,2,21),
#	Date.civil(2012,2,20),
#	Date.civil(2013,2,18),
#	Date.civil(2014,2,17),
#].each do |date|
#		print_tests('Not a holiday', date, ["ca_ns"])
#	end

# ca - part 10
#[
#	Date.civil(2015,2,16),
#	Date.civil(2016,2,15),
#	Date.civil(2017,2,20),
#	Date.civil(2044,2,15),
#].each do |date|
#		print_tests('Nova Scotia Heritage Day', date, ["ca_ns"])
#	end

# ca - part 9
#[
#	Date.civil(2000,2,14),
#	Date.civil(2011,2,14),
#	Date.civil(2012,2,13),
#].each do |date|
#		print_tests('Not a holiday', date, ["ca_bc"])
#	end

# ca - part 8
#[
#	Date.civil(2013,2,11),
#	Date.civil(2014,2,10),
#	Date.civil(2044,2,8),
#].each do |date|
#		print_tests('Family Day', date, ["ca_bc"])
#	end

# ca - part 7
#[
#	Date.civil(1970,2,16),
#	Date.civil(1988,2,15),
#	Date.civil(1989,2,20),
#	Date.civil(2006,2,20),
#	Date.civil(2007,2,19),
#].each do |date|
#		print_tests('Not a holiday', date, ["ca_on"])
#	end

# ca - part 6
#[
#	Date.civil(2008,2,18),
#	Date.civil(2013,2,18),
#	Date.civil(2014,2,17),
#	Date.civil(2044,2,15),
#].each do |date|
#		print_tests('Family Day', date, ["ca_on"])
#	end

# ca - part 5
#[
#	Date.civil(1970,2,16),
#	Date.civil(1988,2,15),
#	Date.civil(1989,2,20),
#	Date.civil(2006,2,20),
#].each do |date|
#		print_tests('Not a holiday', date, ["ca_sk"])
#	end

# ca - part 4
#[
#	Date.civil(2007,2,19),
#	Date.civil(2013,2,18),
#	Date.civil(2014,2,17),
#	Date.civil(2044,2,15),
#].each do |date|
#		print_tests('Family Day', date, ["ca_sk"])
#	end


#ca - part 3
#[
#	Date.civil(1970,2,16),
#	Date.civil(1988,2,15),
#	Date.civil(1989,2,20),
#].each do |date|
#		print_tests('Not a holiday', date, ["ca_ab"])
#	end


# ca - part 2
#[
#	Date.civil(1990,2,19),
#	Date.civil(2013,2,18),
#	Date.civil(2014,2,17),
#	Date.civil(2044,2,15),
#].each do |date|
#		print_tests('Family Day', date, ["ca_ab"])
#	end

# ca - part 1
#{
#	Date.civil(2008,1,1) => 'New Year\'s Day',
#	Date.civil(2008,3,21) => 'Good Friday',
#	Date.civil(2013,3,31) => 'Easter Sunday',
#	Date.civil(2008,3,24) => 'Easter Monday',
#	Date.civil(2008,5,19) => 'Victoria Day',
#	Date.civil(2008,7,1) => 'Canada Day',
#	Date.civil(2008,9,1) => 'Labour Day',
#	Date.civil(2008,10,13) => 'Thanksgiving',
#	Date.civil(2008,12,25) => 'Christmas Day',
#	Date.civil(2008,12,26) => 'Boxing Day'
#}.each do |date, name|
#  print_tests(name, date, ["ca"], ["informal"])
#end

# br
#{
#	Date.civil(2008,1,1) => 'Dia da Confraternização Universal',
#	Date.civil(2005,2,8) => 'Carnaval',
#	Date.civil(2006,2,28) => 'Carnaval',
#	Date.civil(2007,2,20) => 'Carnaval',
#	Date.civil(2008,2,5) => 'Carnaval',
#	Date.civil(2008,3,21) => 'Sexta-feira Santa',
#	Date.civil(2008,3,23) => 'Páscoa',
#	Date.civil(2008,4,21) => 'Dia de Tiradentes',
#	Date.civil(2008,5,1) => 'Dia do Trabalho',
#	Date.civil(2005,5,26) => 'Corpus Christi',
#	Date.civil(2007,6,7) => 'Corpus Christi',
#	Date.civil(2008,5,22) => 'Corpus Christi',
#	Date.civil(2008,9,7) => 'Proclamação da Independência',
#	Date.civil(2008,10,12) => 'Dia de Nossa Senhora Aparecida',
#	Date.civil(2008,11,2) => 'Dia de Finados',
#	Date.civil(2008,11,15) => 'Proclamação da República',
#	Date.civil(2008,12,25) => 'Natal'
#}.each do |date, name|
#  print_tests(name, date, ["br"], ["informal"])
#end

# bg
#{
#	Date.civil(2015,1,1) => "New Year's Day",
#	Date.civil(2015,3,3) => "Liberation Day",
#	Date.civil(2015,3,28) => "Good Friday",
#	Date.civil(2015,3,29) => "Holy Saturday",
#	Date.civil(2015,3,30) => "Easter Sunday",
#	Date.civil(2015,3,31) => "Easter Monday",
#	Date.civil(2015,5,1) => "Labour Day",
#	Date.civil(2015,5,6) => "St. George's Day",
#	Date.civil(2015,5,24) => "Slavic Literacy Day",
#	Date.civil(2015,9,6) => "Unification Day",
#	Date.civil(2015,9,22) => "The Independence Day",
#	Date.civil(2015,11,1) => "Revival Leader's Day",
#	Date.civil(2015,12,24) => "Christmas Eve",
#	Date.civil(2015,12,25) => "Christmas",
#	Date.civil(2015,12,26) => "Christmas"
#}.each do |date, name|
#  print_tests(name, date, ["be_en"])
#end

#be_nl
#{
#  Date.civil(2007,1,1) => 'Nieuwjaar',
#  Date.civil(2007,4,8) => 'Pasen',
#  Date.civil(2007,4,9) => 'Paasmaandag',
#  Date.civil(2007,5,1) => 'Feest van de Arbeid',
#  Date.civil(2007,5,17) => 'O.H. Hemelvaart',
#  Date.civil(2007,5,27) => 'Pinksteren',
#  Date.civil(2007,5,28) => 'Pinkstermaandag',
#  Date.civil(2007,7,21) => 'Nationale Feestdag',
#  Date.civil(2007,8,15) => 'O.L.V. Hemelvaart',
#  Date.civil(2007,11,1) => 'Allerheiligen',
#  Date.civil(2007,11,11) => 'Wapenstilstand 1918',
#  Date.civil(2007,12,25) => 'Kerstmis'
#}.each do |date, name|
#  print_tests(name, date, ["be_nl"], ["informal"])
#end

# be_fr
#{
#  Date.civil(2007,1,1) => 'Jour de l\'an',
#  Date.civil(2007,4,8) => 'Pâques',
#  Date.civil(2007,4,9) => 'Lundi de Pâques',
#  Date.civil(2007,5,1) => 'Fête du travail',
#  Date.civil(2007,5,17) => 'Ascension',
#  Date.civil(2007,5,27) => 'Pentecôte',
#  Date.civil(2007,5,28) => 'Lundi de Pentecôte',
#  Date.civil(2007,7,21) => 'Fête nationale',
#  Date.civil(2007,8,15) => 'Assomption',
#  Date.civil(2007,11,1) => 'Toussaint',
#  Date.civil(2007,11,11) => 'Armistice 1918',
#  Date.civil(2007,12,25) => 'Noël'
#}.each do |date, name|
#  print_tests(name, date, ["be_fr"], ["informal"])
#end

# Aus?
#{
# 'Labour Day' => [
#   [
#     Date.civil(2013,10,7),
#     Date.civil(2012,5,7),
#     Date.civil(2015,10,5),
#     Date.civil(2016,5,2),
#   ],
#   :au_qld,
# ],
# "Queen's Birthday" => {
#   :au_qld => [
#     [
#       Date.civil(2012,6,11),
#       Date.civil(2012, 10, 1),
#       Date.civil(2015, 6, 10),
#       Date.civil(2015, 6, 8),
#       Date.civil(2016, 10, 3),
#     ],
#     :au_qld
#   ],
#  :au_wa => [
#    [
#      Date.civil(2014, 9, 29),
#      Date.civil(2015, 9, 28),
#      Date.civil(2016, 9, 26),
#    ],
#    :au_wa
#   ]
# },
# "Family & Community Day" => [
#   [
#     Date.civil(2014, 9, 29),
#     Date.civil(2015, 9, 28),
#     Date.civil(2016, 9, 26),
#   ],
#   :au_act,
# ],
# 'Australia Day' => {
#   :au_qld => [
#     [
#       Date.civil(2014,1,26),
#     ],
#     :au_qld
#   ],
#  :au_qld_observed => [
#    [
#      Date.civil(2014, 1, 27),
#    ],
#    :au_qld,
#    'observed',
#   ]
# },
# 'Cairns Show' => [
#   [
#     Date.civil(2014,7,18),
#     Date.civil(2013, 7, 19),
#   ],
#   :au_qld_cairns
# ],
# 'Royal Hobart Show' => [
#   [
#     Date.civil(2013, 10, 24),
#     Date.civil(2014, 10, 23),
#     Date.civil(2015, 10, 22),
#     Date.civil(2016, 10, 20),
#   ],
#   :au_tas_south
# ],
# 'Recreation Day' => [
#   [
#     Date.civil(2013, 11, 4),
#     Date.civil(2014, 11, 3),
#     Date.civil(2015, 11, 2),
#     Date.civil(2016, 11, 7),
#   ],
#   :au_tas_north,
# ],
# 'Not a holiday' => {
#   :au_tas => [
#     [
#       Date.civil(2015, 12, 26),
#     ],
#     :au_tas,
#   ],
#   :au_qld_brisbane => [
#     [
#       Date.civil(2015, 11, 14),
#     ],
#     :au_qld_brisbane,
#   ],
#   :au_nt => [
#     [
#       Date.civil(2015, 12, 26),
#       Date.civil(2016, 12, 25),
#     ],
#     :au_nt,
#   ],
#   :au_vic => [
#     [
#       Date.civil(2014,11,4),
#       Date.civil(2015, 11, 3),
#       Date.civil(2016, 12, 25),
#     ],
#     :au_vic
#   ],
#   :au_sa => [
#     [
#       Date.civil(2014, 5, 19),
#       Date.civil(2005, 3, 14),
#       Date.civil(2015, 12, 26),
#     ],
#     :au_sa,
#   ],
#   :au_qld_observed => [
#     [
#       Date.civil(2015, 4, 27),
#     ],
#     :au_qld,
#     'observed',
#   ],
#   :au_qld => [
#     [
#       Date.civil(2014, 11, 14),
#     ],
#     :au_qld,
#   ],
# },
# 'Melbourne Cup Day' => [
#   [
#     Date.civil(2014,11,4),
#     Date.civil(2015,11,3),
#   ],
#   :au_vic_melbourne,
# ],
# 'Friday before the AFL Grand Final' => [
#   [
#     Date.civil(2015,10,2),
#     Date.civil(2016,9,30),
#   ],
#   :au_vic,
# ],
# "May Public Holiday" => [Date.civil(2005, 5, 16), :au_sa],
# "March Public Holiday" => [
#   [
#     Date.civil(2014, 3, 10),
#     Date.civil(2015, 3, 9),
#     Date.civil(2016, 3, 14),
#     Date.civil(2017, 3, 13),
#   ],
#   :au_sa,
# ],
# "ANZAC Day" => {
#   :au_qld_au_wd => [
#     [
#       Date.civil(2015, 4, 25),
#     ],
#     ['au_qld', 'au_wa'],
#   ],
#   :au_qld_observed => [
#     [
#       Date.civil(2015, 4, 27),
#     ],
#     :au_wa,
#     'observed',
#   ],
# },
# "Boxing Day" => {
#   :au_qld => [
#     [
#       Date.civil(2015, 12, 26),
#     ],
#     :au_qld,
#   ],
#   :au_qld_observed => [
#     [
#       Date.civil(2015, 12, 28),
#     ],
#     :au_qld,
#     'observed',
#   ],
#   :au_sa => [
#     [
#       Date.civil(2015, 12, 28),
#       Date.civil(2016, 12, 27),
#     ],
#     :au_sa,
#   ],
#   :au_tas => [
#     [
#       Date.civil(2015, 12, 28),
#     ],
#     :au_tas,
#   ],
#   :au_nt => [
#     [
#       Date.civil(2015, 12, 28),
#       Date.civil(2016, 12, 26),
#     ],
#     :au_nt,
#   ],
#   :au_vic => [
#     [
#       Date.civil(2016, 12, 26),
#     ],
#     :au_vic,
#   ],
# },
# 'G20 Day' => [
#   [
#     Date.civil(2014,11,14)
#   ],
#   :au_qld_brisbane,
# ],
# 'Royal Hobart Regatta' => [
#   [
#     Date.civil(2012, 2, 13),
#     Date.civil(2014, 2, 10),
#     Date.civil(2015, 2, 9),
#     Date.civil(2016, 2, 8),
#   ],
#   :au_tas_south,
# ],
# "Christmas Day" => {
#   "au_qld" => [
#     [
#       Date.civil(2016, 12, 25),
#     ],
#     "au_qld"
#   ],
#  "au_qld_observed" => [
#    [
#      Date.civil(2016, 12, 27),
#    ],
#    "au_qld",
#    "observed",
#   ],
#  "au_nsw" => [
#     [
#       Date.civil(2016, 12, 25),
#     ],
#     "au_nsw"
#   ],
#  "au_nsw_observed" => [
#    [
#      Date.civil(2016, 12, 27),
#    ],
#    "au_nsw",
#    "observed",
#   ],
#  "au_act" => [
#     [
#       Date.civil(2016, 12, 25),
#     ],
#     "au_act"
#   ],
#  "au_act_observed" => [
#    [
#      Date.civil(2016, 12, 27),
#    ],
#    "au_act",
#    "observed",
#   ],
#   "au_tas" => [
#     [
#       Date.civil(2016, 12, 25),
#     ],
#     "au_tas"
#   ],
#  "au_tas_observed" => [
#    [
#      Date.civil(2016, 12, 27),
#    ],
#    "au_tas",
#    "observed",
#   ],
#   "au_wa" => [
#     [
#       Date.civil(2016, 12, 25),
#     ],
#     "au_wa"
#   ],
#  "au_wa_observed" => [
#    [
#      Date.civil(2016, 12, 27),
#    ],
#    "au_wa",
#    "observed",
#   ],
#   "au_sa" => [
#     [
#       Date.civil(2016, 12, 25),
#     ],
#     "au_sa"
#   ],
#  "au_sa_observed" => [
#    [
#      Date.civil(2016, 12, 26),
#    ],
#    "au_sa",
#    "observed",
#   ],
#  "au_vic" => [
#    [
#      Date.civil(2016, 12, 27),
#    ],
#    "au_vic",
#   ],
#   "au_nt" => [
#     [
#       Date.civil(2016, 12, 27),
#     ],
#     "au_nt",
#   ]
# }
#}.each do |name, values|
#  if values.is_a?(Array)
#    process_data(name, values)
#  elsif values.is_a?(Hash)
#    values.each do |key, data|
#      process_data(name, data)
#    end
#  end
#end

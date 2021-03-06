//Добрый день!
//В ТЗ поставлена задача доработать отчет ... Описанные вами доработки не меняют текущую реализацию доработки, она работает так как написано в ТЗ (код запроса будет приведен ниже), в ТЗ не сказано изменить алгоритм вывода выбранных данных (который по поставленной вами задаче, реализован в обработке на ранних этапах). Напоминаю о данном алгоритме так как вопрос с которым обращалась А.А. Балашова, И.В. Бунчук и вы отражен в работе данного алгоритма о чем я неоднократно сообщал. Сообщаю еще раз: После выборки данных, алгоритм выводит каждый тип документов и его данные до тех пока данное условие ЛОЖЬ: "(Уже показанное Количество по типу документа) > ВыборкаКр43 И (Уже показанное Количество по типу документа) - (Выборка Количество документа) >= ВыборкаКр43"

//(Важно: отчеты отсортированы по дате документа)

//Например: 

//Начало:
//ВыборкаКр43 = 1000. 
//Выборка[0] отчет производства дата 01.01 (1) = 500, Выборка[1] отчет производства дата 02.01 (2) = 600, Выборка[2] отчет производства дата 03.01 (3) = 100
//"Уже показанное Количество по типу документа" = 0

//Шаг 1:
//Первый документ показываем так как условие ЛОЖЬ:
//(Уже показанное = 0) > ВыборкаКр43 = 1000 И (Уже показанное Количество = 0) - (Выборка Количество документа (1) = 500) >= ВыборкаКр43 = 1000

//Шаг 2:
//Второй документ показываем так как условие ЛОЖЬ:
//(Уже показанное = 500) > ВыборкаКр43 = 1000 И (Уже показанное Количество = 500) - (Выборка Количество документа (2) = 600) >= ВыборкаКр43 = 1000

//Шаг 3:
//Третий документ НЕ показываем так как условие ИСТИНА:
//(Уже показанное = 1100) > ВыборкаКр43 = 1000 И (Уже показанное Количество = 1100) - (Выборка Количество документа (3) = 100) >= ВыборкаКр43 = 1000

&НаСервере
Функция ПолучитьМакетНаСервере()
	Возврат РеквизитФормыВЗначение("Объект").ПолучитьМакет("МакетВМ");
КонецФункции

&НаСервере
Процедура ЗаполнитьОбластьМакета(ОбластьСсылка, областьДанныеТолькоРеализация, Выборка, имяОбласти = "", ОТИсчерпан = Истина, ПРПИсчерпан = Истина, РИсчерпан = Истина, ПРРИсчерпан = Истина, Вывести = Ложь)
	
	ОбластьСсылка.Параметры.Заполнить(Выборка);
	
	От 	     	= Ложь;
	ПеремПриход = Ложь;
	ПеремРасход = Ложь;
	Реал 	    = Ложь;

	
	Если имяОбласти = "ОблДанныеОтчеты" Тогда	
		
		// ПРИХОД
		Если НЕ ОТИсчерпан И ЗначениеЗаполнено(Выборка.ОтчетПроизводства) Тогда
			обк1 = Выборка.ОтчетПроизводства.ПолучитьОбъект();
			ОбластьСсылка.Параметры.ОтчетПроизводства = обк1.Номер;
			ОбластьСсылка.Параметры.ОТДата = обк1.Дата;
				
			От = Истина;
		Иначе
			обк1 = Документы.ОтчетПроизводстваЗаСмену.ПустаяСсылка();
			ОбластьСсылка.Параметры.ОтчетПроизводства = "";
			ОбластьСсылка.Параметры.ОТДата = "";
			
			ОбластьСсылка.Параметры.ОТКоличество 	  	 	= "";
			ОбластьСсылка.Параметры.ОТВиноматериал 	     	= "";
			ОбластьСсылка.Параметры.ОТВиноматериалКодЕГАИС  = "";
			ОбластьСсылка.Параметры.ОТЛитр  				= "";			
		КонецЕсли; 		
		
		Если НЕ ПРПИсчерпан И ЗначениеЗаполнено(Выборка.ПеремПриходСсылка) Тогда
			обк2 = Выборка.ПеремПриходСсылка.ПолучитьОбъект();
			ОбластьСсылка.Параметры.ПеремПриходСсылка = обк2.Номер;
			ОбластьСсылка.Параметры.ПеремПриходДата   = обк2.Дата;
			
			ПеремПриход = Истина;
		Иначе
			обк2 = Документы.ПеремещениеТоваров;
			ОбластьСсылка.Параметры.ПеремПриходСсылка 	  = "";
			ОбластьСсылка.Параметры.ПеремПриходДата   	  = "";
			
			ОбластьСсылка.Параметры.ПеремПриходКоличество = "";
			ОбластьСсылка.Параметры.ПеремПриходЛитр  	  = "";
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Выборка.ОтчетПроизводства) И НЕ ЗначениеЗаполнено(Выборка.ПеремПриходСсылка) Тогда
			ОбластьСсылка.Параметры.Дт43 = "";
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Выборка.РеалСсылка) И НЕ ЗначениеЗаполнено(Выборка.ПеремРасходСсылка) Тогда
			ОбластьСсылка.Параметры.Кр43 = "";
		КонецЕсли;
		
		
		
		// РАСХОД
		РеализацияЗаполненаПервойСтрокой = Ложь;
		Если НЕ ПРРИсчерпан И ЗначениеЗаполнено(Выборка.ПеремРасходСсылка) Тогда
			
			// ПЕРЕМЕЩЕНИЕ
			обк4 = Выборка.ПеремРасходСсылка.ПолучитьОбъект();
			ОбластьСсылка.Параметры.ТипДокумента 		   	= "Розница";
			ОбластьСсылка.Параметры.КонтрагентРасходСсылка 	= "Фирменная розница";
			ОбластьСсылка.Параметры.КонтрагентРасходИНН    	= Объект.Организация.ИНН; //"9103002616"
			ОбластьСсылка.Параметры.КонтрагентРасходКПП    	= Выборка.ПеремСкладПолучательКПП;
			ОбластьСсылка.Параметры.ДокументРасходСсылка   	= обк4.Номер;
			ОбластьСсылка.Параметры.ДокументРасходДата     	= обк4.Дата;
			ОбластьСсылка.Параметры.РасходЛитры   		   	= Выборка.ПеремРасходЛитр;
			ОбластьСсылка.Параметры.РасходКоличество 	   	= Выборка.ПеремРасходКоличество;            
		
			РасходЛитры 									= ?(Выборка.РеалЛитр = NULL, Число(Выборка.ПеремРасходЛитр), Число(Выборка.РеалЛитр) );			
			ОбластьСсылка.Параметры.Тонн 					= РасходЛитры / 1000;
			
			ОбластьСсылка.Параметры.АкцизВинограда 	       	= ?(Выборка.ПеремАкцизВиноград = NULL,    0, Число(Выборка.ПеремАкцизВиноград) );
			ОбластьСсылка.Параметры.ВычетАкциза 	       	= ?(Выборка.ПеремВычетАкциз = NULL,    	 0, Число(Выборка.ПеремВычетАкциз) );			
			
			ПеремРасход = Истина;
				
		// РЕАЛИЗАЦИЯ	
		ИначеЕсли НЕ РИсчерпан И ЗначениеЗаполнено(Выборка.РеалСсылка) Тогда
			ЗаполнитьОбластьДанныхРасход(Выборка, ОбластьСсылка);
			РеализацияЗаполненаПервойСтрокой = Истина;
			Реал = Истина;			
		Иначе			
			ОчиститьОбластьДанныхРасход(ОбластьСсылка);			
			РеализацияЗаполненаПервойСтрокой = Ложь;			
		КонецЕсли;
		
		
	КонецЕсли;
		
	Если Вывести ИЛИ От ИЛИ ПеремПриход ИЛИ ПеремРасход ИЛИ Реал  Тогда
		Объект.ТабДок.Вывести(ОбластьСсылка);
		
		// РЕАЛИЗАЦИЯ
		Если НЕ РеализацияЗаполненаПервойСтрокой И НЕ РИсчерпан И ЗначениеЗаполнено(Выборка.РеалСсылка) Тогда			
			ЗаполнитьОбластьДанныхРасход(Выборка, областьДанныеТолькоРеализация);		
			Объект.ТабДок.Вывести(областьДанныеТолькоРеализация);		
		Иначе			
			ОчиститьОбластьДанныхРасход(областьДанныеТолькоРеализация);		
		КонецЕсли;

		
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура СформироватьНаСервере()
	
	Запрос = Новый Запрос;
	
	// 1 - ВЫБОР Алкоголь доп. свед. с ОТБОРОМ НОМЕНКЛАТУРЫ С ГОДОМ УРОЖАЯ БОЛЬШЕ ИЛИ РАВНО УКАЗАННОЙ ПОЛЬЗОВАТЕЛЕМ
	// 2 - ВЫБОР НОМЕНКЛАТУРЫ С УКАЗАНЫМ ГОДОМ УРОЖАЯ ПО КОТОРОЙ ЕСТЬ ОСТАТКИ НА УКАЗАННОМ ПОЛЬЗОВАТЕЛЕМ СЧЕТЕ
	

	
	// 3.1 ВЫБОР _ВИНОМАТЕРИАЛА_ ИЗ ОТЧЕТА ПРОИЗВОДСТВА ПО УКАЗАННОМУ ЦЕХУ ЗАТРАТ
	// 3.2 ВЫБОР _НОМЕНКЛАТУРЫ_ ИЗ ОТЧЕТА ПРОИЗВОДСТВА ПО УКАЗАННОМУ ЦЕХУ ЗАТРАТ
	// 3.3 ВЫБОР _ВИНОМАТЕРИАЛА_ И _НОМЕНКЛАТУРЫ_ ИЗ ОТЧЕТА ПРОИЗВОДСТВА ПО УКАЗАННОМУ ЦЕХУ ЗАТРАТ В ЕДИНУЮ ТАБЛИЦУ
	// 4 ВЫБОР ПЕРЕМЕЩЕНИЙ НА СКЛАД получатель (ПРИХОД), отбор: номенклатура ЕСТЬ НА ОСТАТКАХ + с СООТВ. ГОДОМ УРОЖАЯ
	// 5 ОБЪЕДИНЕНИЕ (ВЫБРАННЫХ РАНЕЕ) ПЕРЕМЕЩЕНИЙ НА СКЛАД (ПРИХОД) И ОТЧЕТОВ ПРОИЗВОДСТВА ДАТА (ДЕНЬ) КОТОРЫХ РАВНЫ
	
	// РЕЗУЛЬТАТ ВЫБОРКИ 3,4,5 - ВЫБРАНЫ ПРИХОДНЫЕ документы (ОТЧЕТ ПРОИЗВОДСТВА + ПЕРЕМЕЩЕНИЯ),
	//	отбор: НОМЕНКЛАТУРЕ КОТОРАЯ ЕСТЬ НА ОСТАТКАХ И ГОД УРОЖАЯ СООТВ. ОТБОРУ
	
	// 6 ВЫБОР РЕАЛИЗАЦИЙ за указанный пользователем период и номенклатура которых есть на остатках + соотв. год урожая
	// 7 ВЫБОР ПЕРЕМЕЩЕНИЙ от СКЛАД отправитель (РАСХОД) за указанный пользователем период и номенклатура ЕСТЬ НА ОСТАТКАХ + соотв. год урожая
	// 8 ОБЪЕДИНЕНИЕ (ВЫБРАННЫХ РАНЕЕ) РЕАЛИЗАЦИЙ И ПЕРЕМЕЩЕНИЙ от СКЛАД (РАСХОД), НОМЕНКЛАТУРА И ССЫЛКА НА ОТЧЕТ ПРОИЗВОДСТВА КОТОРЫХ РАВНЫ
	
	// РЕЗУЛЬТАТ ВЫБОРКИ 6,7,8 - ВЫБРАНЫ РАСХОДНЫЕ документы (РЕАЛИЗАЦИЯ ТОВАРОВ + ПЕРЕМЕЩЕНИЯ),
	//	отбор: НОМЕНКЛАТУРЕ КОТОРАЯ ЕСТЬ НА ОСТАТКАХ И ГОД УРОЖАЯ СООТВ. ОТБОРУ
	
	// 9 ОБЪЕДИНЕНИЕ (ВЫБРАННЫХ РАНЕЕ) ПРИХОДНЫХ и РАСХОДНЫХ документов, объединение по Отчет производства и Номенклатура,
	//  отбор: НОМЕНКЛАТУРА И ССЫЛКА НА ОТЧЕТ ПРОИЗВОДСТВА КОТОРЫХ РАВНЫ
	// 10 Добавляем Показатели (Остаток, Дт43, Кт43) к Результату шага 9 (соединяем по Номенклатуре)
	// 11 Добавляем Показатели из Алкоголь доп. сведения (переводим в литры), соединяем по Номенклатуре
	// 12 ВЫБОР АВИЗОВОК (ОБЕРТКА)
	// 'ОБОРАЧИВАЕМ' РЕЗУЛЬТАТ ПРЕЖНЕЙ ВЕРСИИ ОБРАБОТКИ СОЕДИНЯЕМ С ВЫБОРКОЙ АВИЗОВОК
	
	Запрос.Текст = 		
	"	// 1 - ВЫБОР Алкоголь доп. свед. с ОТБОРОМ НОМЕНКЛАТУРЫ С ГОДОМ УРОЖАЯ БОЛЬШЕ ИЛИ РАВНО УКАЗАННОЙ ПОЛЬЗОВАТЕЛЕМ
	|ВЫБРАТЬ
	|АлкогольДополнительныеСведения.Владелец                                                     КАК Номенклатура,
	|АлкогольДополнительныеСведения.ВидБутылки.Объем                                             КАК Объем,
	|ЕСТЬNULL(АлкогольДополнительныеСведения.Акциз, ЗНАЧЕНИЕ(Справочник.Акцизы.ПустаяСсылка))    КАК Акциз,
	|АлкогольДополнительныеСведения.ТипАлкогольнойЛицензииПроизводитель                          КАК ТипАП
	|ПОМЕСТИТЬ ВТНоменклатуаС2015
	|ИЗ
	|Справочник.АлкогольДополнительныеСведения КАК АлкогольДополнительныеСведения
	|ГДЕ
	|АлкогольДополнительныеСведения.ГодУрожая >= &ГодУрожая

	|;
	|  // 1.1 - ВЫБОР доп. информацию из регистра сведений СтавкиАкцизаАлкоголь

	|	    ВЫБРАТЬ РАЗЛИЧНЫЕ
	|			СтавкиАкцизаАлкоголь.ТипАлкогольнойЛицензии КАК ТипАП,
	|			СтавкиАкцизаАлкоголь.КоэффКГВП КАК КоэффКГВП,
	|			СтавкиАкцизаАлкоголь.КоэффКВ КАК КоэффКВ
	|			ПОМЕСТИТЬ ВТСтавкиАП
	|		ИЗ
	|			РегистрСведений.СтавкиАкцизаАлкоголь.СрезПоследних(&датаКонец, КоэффКГВП > 0 
	|			И НЕ ТипАлкогольнойЛицензии ЕСТЬ NULL) КАК СтавкиАкцизаАлкоголь 
	|;
	|  // 1.1 - СОЕДИНЯЕМ доп. информацию и информацию алкоголь доп. сведения
	|	    ВЫБРАТЬ
	|			НоменклатуаС2015.Номенклатура 		КАК Номенклатура,
	|			НоменклатуаС2015.Акциз.Код          КАК АкцизКод,
	|			ЕСТЬNULL(НоменклатуаС2015.Объем, 0) КАК Объем,
	|			ЕСТЬNULL(СтавкиАП.КоэффКГВП, 0) 	КАК КоэффКГВП,
	|			ЕСТЬNULL(СтавкиАП.КоэффКВ, 0) 		КАК КоэффКВ
	|			ПОМЕСТИТЬ ВТСведенияАлкоголь
	|		ИЗ
	|			ВТНоменклатуаС2015 КАК НоменклатуаС2015 
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТСтавкиАП КАК СтавкиАП
	|			ПО НоменклатуаС2015.ТипАП = СтавкиАП.ТипАП
	|;
	|
	|    // 2 - ВЫБОР НОМЕНКЛАТУРЫ С УКАЗАНЫМ ГОДОМ УРОЖАЯ ПО КОТОРОЙ ЕСТЬ ОСТАТКИ НА УКАЗАННОМ ПОЛЬЗОВАТЕЛЕМ СЧЕТЕ
	|	ВЫБРАТЬ
	|		ХозрасчетныйОстаткиИОбороты.Субконто1 КАК Номенклатура,
	|		ХозрасчетныйОстаткиИОбороты.КоличествоНачальныйОстаток КАК Остаток,
	|		ХозрасчетныйОстаткиИОбороты.КоличествоОборотДт КАК Дт43,
	|		ХозрасчетныйОстаткиИОбороты.КоличествоОборотКт КАК Кр43
	|	ПОМЕСТИТЬ ВТХозрасчетный
	|	ИЗ
	|		РегистрБухгалтерии.Хозрасчетный.ОстаткиИОбороты(
	|				НАЧАЛОПЕРИОДА(&датаНач, ДЕНЬ),
	|				КОНЕЦПЕРИОДА(&датаКонец, ДЕНЬ),
	|				,
	|				ДвиженияИГраницыПериода,
	|				Счет В ИЕРАРХИИ (&Счет),
	|				,
	|				Субконто1 В
	|						(ВЫБРАТЬ
	|							ВТНоменклатуаС2015.Номенклатура
	|						ИЗ
	|							ВТНоменклатуаС2015)
	|					И Субконто3 = &ВыбСклад) КАК ХозрасчетныйОстаткиИОбороты
	|	ГДЕ
	|		ХозрасчетныйОстаткиИОбороты.КоличествоОборотКт > 0
	|;
	|
	|
	|
	|// 3.1 ВЫБОР _ВИНОМАТЕРИАЛА_ ИЗ ОТЧЕТА ПРОИЗВОДСТВА ПО УКАЗАННОМУ ЦЕХУ ЗАТРАТ
	|	ВЫБРАТЬ
	|		ТЧМатериалы.Ссылка КАК ОтчетПроизводства,
	|		ТЧМатериалы.Продукция КАК Продукция,
	|		ТЧМатериалы.Номенклатура КАК Виноматериал
	|	ПОМЕСТИТЬ ВТОТПроизводстваВМ
	|	ИЗ
	|		Документ.ОтчетПроизводстваЗаСмену.Материалы КАК ТЧМатериалы
	|	ГДЕ
	|		ТЧМатериалы.Продукция В
	|				(ВЫБРАТЬ
	|					ВТХозрасчетный.Номенклатура
	|				ИЗ
	|					ВТХозрасчетный)
	|		И ТЧМатериалы.Ссылка.Склад = &ВыбЦехЗатрат
	|		И ТЧМатериалы.Номенклатура.КодЕГАИС <> """"
	|;
	|	
	|
	|// 3.2 ВЫБОР _НОМЕНКЛАТУРЫ_ ИЗ ОТЧЕТА ПРОИЗВОДСТВА ПО УКАЗАННОМУ ЦЕХУ ЗАТРАТ
	|	ВЫБРАТЬ
	|		ТЧПродукция.Ссылка КАК ОтчетПроизводства,
	|		ТЧПродукция.Номенклатура КАК Продукция,
	|		ТЧПродукция.ДатаРозлива КАК ДатаРозлива,
	|		СУММА(ТЧПродукция.Количество) КАК Кол
	|	ПОМЕСТИТЬ ВТОТПроизводстваНом
	|	ИЗ
	|		Документ.ОтчетПроизводстваЗаСмену.Продукция КАК ТЧПродукция
	|	ГДЕ
	|		ТЧПродукция.Номенклатура В
	|				(ВЫБРАТЬ
	|					ВТХозрасчетный.Номенклатура
	|				ИЗ
	|					ВТХозрасчетный)
	|		И ТЧПродукция.Ссылка.Склад = &ВыбЦехЗатрат
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ТЧПродукция.Ссылка,
	|		ТЧПродукция.Номенклатура,
	|		ТЧПродукция.ДатаРозлива
	|;
	|	
	|
	|// 3.3 ВЫБОР _ВИНОМАТЕРИАЛА_ И _НОМЕНКЛАТУРЫ_ ИЗ ОТЧЕТА ПРОИЗВОДСТВА ПО УКАЗАННОМУ ЦЕХУ ЗАТРАТ В ЕДИНУЮ ТАБЛИЦУ
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ВТОТПроизводстваВМ.ОтчетПроизводства КАК ОтчетПроизводства,
	|		ВТОТПроизводстваВМ.Продукция КАК Номенклатура,
	|		ВТОТПроизводстваВМ.Виноматериал КАК Виноматериал,
	|		ВТОТПроизводстваНом.ДатаРозлива КАК ДатаРозлива,
	|		ВТОТПроизводстваНом.Кол КАК ОТКоличество
	|	ПОМЕСТИТЬ ВТОТПроизводстваНоменклатураИВМ
	|	ИЗ
	|		ВТОТПроизводстваВМ КАК ВТОТПроизводстваВМ
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТОТПроизводстваНом КАК ВТОТПроизводстваНом
	|			ПО ВТОТПроизводстваВМ.ОтчетПроизводства = ВТОТПроизводстваНом.ОтчетПроизводства
	|				И ВТОТПроизводстваВМ.Продукция = ВТОТПроизводстваНом.Продукция
	|;
	|	
	|
	|// 4 ВЫБОР ПЕРЕМЕЩЕНИЙ НА СКЛАД получатель (ПРИХОД), отбор: номенклатура ЕСТЬ НА ОСТАТКАХ + с СООТВ. ГОДОМ УРОЖАЯ
	|	ВЫБРАТЬ
	|		Перемещение.Ссылка КАК ПеремСсылка,
	|		Перемещение.Номенклатура КАК ПеремНоменклатура,
	|		Перемещение.ДокументПроизводства КАК ДокументПроизводства,
	|		СУММА(Перемещение.Количество) КАК ПеремКоличество
	|	ПОМЕСТИТЬ ВТПеремещение
	|	ИЗ
	|		Документ.ПеремещениеТоваров.Товары КАК Перемещение
	|	ГДЕ
	|		Перемещение.Ссылка.Организация = &ОргСсылка
	|		И Перемещение.Ссылка.СкладОтправитель = &ВыбЦехЗатрат
	|		И Перемещение.Ссылка.СкладПолучатель = &ВыбСклад
	|		И Перемещение.Ссылка.Проведен
	|		И Перемещение.Номенклатура В
	|				(ВЫБРАТЬ
	|					ВТХозрасчетный.Номенклатура
	|				ИЗ
	|					ВТХозрасчетный)
	|	
	|	СГРУППИРОВАТЬ ПО
	|		Перемещение.Ссылка,
	|		Перемещение.Номенклатура,
	|		Перемещение.ДокументПроизводства
	|;
	|	
	|
	|// 5 ОБЪЕДИНЕНИЕ (ВЫБРАННЫХ РАНЕЕ) ПЕРЕМЕЩЕНИЙ НА СКЛАД (ПРИХОД) И ОТЧЕТОВ ПРОИЗВОДСТВА ДАТА (ДЕНЬ) КОТОРЫХ РАВНЫ
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		НАЧАЛОПЕРИОДА(ОТ.ОтчетПроизводства.Ссылка.Дата, ДЕНЬ) КАК Период,
	|		ОТ.ОтчетПроизводства КАК ОтчетПроизводства,
	|		ВЫБОР
	|			КОГДА ОТ.Номенклатура ЕСТЬ NULL
	|				ТОГДА Перемещение.ПеремНоменклатура
	|			ИНАЧЕ ОТ.Номенклатура
	|		КОНЕЦ КАК Номенклатура,
	|		ОТ.ДатаРозлива КАК ДатаРозлива,
	|		ОТ.Виноматериал КАК Виноматериал,
	|		ОТ.ОТКоличество КАК ОТКоличество,
	|		Перемещение.ПеремСсылка КАК ПеремСсылка,
	|		Перемещение.ПеремКоличество КАК ПеремКоличество
	|	ПОМЕСТИТЬ ВТОТИПеремещениеНаСклад
	|	ИЗ
	|		ВТОТПроизводстваНоменклатураИВМ КАК ОТ
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТПеремещение КАК Перемещение
	|			ПО ОТ.Номенклатура = Перемещение.ПеремНоменклатура
	|				И НАЧАЛОПЕРИОДА(ОТ.ОтчетПроизводства.Ссылка.Дата, ДЕНЬ) = НАЧАЛОПЕРИОДА(Перемещение.ПеремСсылка.Дата, ДЕНЬ)
	|;
	|	
	|
	|// РЕЗУЛЬТАТ ВЫБОРКИ 3,4,5 - ВЫБРАНЫ ПРИХОДНЫЕ документы (ОТЧЕТ ПРОИЗВОДСТВА + ПЕРЕМЕЩЕНИЯ), отбор: НОМЕНКЛАТУРЕ КОТОРАЯ ЕСТЬ НА ОСТАТКАХ И ГОД УРОЖАЯ СООТВ. ОТБОРУ
	|
	|
	|
	|// 6 ВЫБОР РЕАЛИЗАЦИЙ за указанный пользователем период и номенклатура которых есть на остатках + соотв. год урожая
	|	ВЫБРАТЬ
	|		Реализация.Ссылка КАК РеалСсылка,
	|		Реализация.Номенклатура КАК РеалНоменклатура,
	|		Реализация.ДокументПроизводства КАК ДокументПроизводства,
	|		Реализация.ДатаВыпуска КАК ДатаВыпуска,
	|
	|		Реализация.СуммаАкцизаВиноград КАК АкцизВиноград,
	|		Реализация.СуммаАкцизаВычет КАК ВычетАкциз,
	|
	|		СУММА(Реализация.Количество) КАК РеалКоличество
	|	ПОМЕСТИТЬ ВТРеализация
	|	ИЗ
	|		Документ.РеализацияТоваровУслуг.Товары КАК Реализация
	|	ГДЕ
	|		Реализация.Ссылка.Организация = &ОргСсылка
	|		И Реализация.Ссылка.Склад = &ВыбСклад
	|		И Реализация.Ссылка.Проведен
	|		И Реализация.Номенклатура В
	|				(ВЫБРАТЬ
	|					ВТХозрасчетный.Номенклатура
	|				ИЗ
	|					ВТХозрасчетный)
	|		И Реализация.Ссылка.Дата МЕЖДУ НАЧАЛОПЕРИОДА(&датаНач, ДЕНЬ) И КОНЕЦПЕРИОДА(&датаКонец, ДЕНЬ)
	|	
	|	СГРУППИРОВАТЬ ПО
	|		Реализация.Ссылка,
	|		Реализация.Номенклатура,
	|		Реализация.ДокументПроизводства,
	|		Реализация.ДатаВыпуска,
	|		СуммаАкцизаВиноград,
	|		СуммаАкцизаВычет
	|;
	|	
	|
	|// 7 ВЫБОР ПЕРЕМЕЩЕНИЙ от СКЛАД отправитель (РАСХОД) за указанный пользователем период и номенклатура ЕСТЬ НА ОСТАТКАХ + соотв. год урожая
	|	ВЫБРАТЬ
	|		Перемещение.Ссылка КАК ПеремСсылка,
	|		Перемещение.Номенклатура КАК ПеремНоменклатура,
	|		Перемещение.ДокументПроизводства КАК ДокументПроизводства,
	|
	|		Перемещение.СуммаАкцизаВиноград КАК АкцизВиноград,
	|		Перемещение.СуммаАкцизаВычет КАК ВычетАкциз,
	|
	|		СУММА(Перемещение.Количество) КАК ПеремКоличество
	|	ПОМЕСТИТЬ ВТПеремещениеПродажа
	|	ИЗ
	|		Документ.ПеремещениеТоваров.Товары КАК Перемещение
	|	ГДЕ
	|		Перемещение.Ссылка.Организация = &ОргСсылка
	|		И Перемещение.Ссылка.СкладОтправитель = &ВыбСклад
	|		И Перемещение.Ссылка.Проведен
	|		И Перемещение.Номенклатура В
	|				(ВЫБРАТЬ
	|					ВТХозрасчетный.Номенклатура
	|				ИЗ
	|					ВТХозрасчетный)
	|		И Перемещение.Ссылка.Дата МЕЖДУ НАЧАЛОПЕРИОДА(&датаНач, ДЕНЬ) И КОНЕЦПЕРИОДА(&датаКонец, ДЕНЬ)
	|	
	|	СГРУППИРОВАТЬ ПО
	|		Перемещение.Ссылка,
	|		Перемещение.Номенклатура,
	|		Перемещение.ДокументПроизводства,
	|		СуммаАкцизаВиноград,
	|		СуммаАкцизаВычет
	|;
	|	
	|
	|// 8 ОБЪЕДИНЕНИЕ (ВЫБРАННЫХ РАНЕЕ) РЕАЛИЗАЦИЙ И ПЕРЕМЕЩЕНИЙ от СКЛАД (РАСХОД), НОМЕНКЛАТУРА И ССЫЛКА НА ОТЧЕТ ПРОИЗВОДСТВА КОТОРЫХ РАВНЫ
	|	ВЫБРАТЬ
	|		ВЫБОР
	|			КОГДА Реализация.ДокументПроизводства ЕСТЬ NULL
	|				ТОГДА Перемещение.ДокументПроизводства
	|			ИНАЧЕ Реализация.ДокументПроизводства
	|		КОНЕЦ КАК ДокументПроизводства,
	|		Реализация.ДатаВыпуска КАК ДатаВыпуска,
	|		ВЫБОР
	|			КОГДА Реализация.РеалНоменклатура ЕСТЬ NULL
	|				ТОГДА Перемещение.ПеремНоменклатура
	|			ИНАЧЕ Реализация.РеалНоменклатура
	|		КОНЕЦ КАК Номенклатура,
	|		Перемещение.ПеремКоличество КАК ПеремКоличество,
	|		Реализация.РеалКоличество КАК РеалКоличество,
	|
	|		Реализация.АкцизВиноград КАК РеалАкцизВиноград,
	|		Реализация.ВычетАкциз КАК РеалВычетАкциз,
	|		Перемещение.АкцизВиноград КАК ПеремАкцизВиноград,
	|		Перемещение.ВычетАкциз КАК ПеремВычетАкциз,
	|
	|		Перемещение.ПеремСсылка КАК ПеремСсылка,
	|		Реализация.РеалСсылка КАК РеалСсылка
	|	ПОМЕСТИТЬ ВТРеалИПеремПродажа
	|	ИЗ
	|		ВТПеремещениеПродажа КАК Перемещение
	|			ПОЛНОЕ СОЕДИНЕНИЕ ВТРеализация КАК Реализация
	|			ПО Перемещение.ДокументПроизводства = Реализация.ДокументПроизводства
	|				И Перемещение.ПеремНоменклатура = Реализация.РеалНоменклатура
	|;
	|
	|// РЕЗУЛЬТАТ ВЫБОРКИ 6,7,8 - ВЫБРАНЫ РАСХОДНЫЕ документы (РЕАЛИЗАЦИЯ ТОВАРОВ + ПЕРЕМЕЩЕНИЯ), отбор: НОМЕНКЛАТУРЕ КОТОРАЯ ЕСТЬ НА ОСТАТКАХ И ГОД УРОЖАЯ СООТВ. ОТБОРУ
	|
	|
	|
	|
	|
	|
	|// 9 ОБЪЕДИНЕНИЕ (ВЫБРАННЫХ РАНЕЕ) ПРИХОДНЫХ и РАСХОДНЫХ документов, объединение по Отчет производства и Номенклатура, отбор: НОМЕНКЛАТУРА И ССЫЛКА НА ОТЧЕТ ПРОИЗВОДСТВА КОТОРЫХ РАВНЫ
	|	ВЫБРАТЬ
	|		ВТОТИПеремещениеНаСклад.ОтчетПроизводства КАК ОтчетПроизводства,
	|		ВТОТИПеремещениеНаСклад.ДатаРозлива КАК ДатаРозлива,
	|		ВЫБОР
	|			КОГДА ВТРеалИПеремПродажа.Номенклатура ЕСТЬ NULL
	|				ТОГДА ВТОТИПеремещениеНаСклад.Номенклатура
	|			ИНАЧЕ ВТРеалИПеремПродажа.Номенклатура
	|		КОНЕЦ КАК Номенклатура,
	|		ВТРеалИПеремПродажа.ПеремСсылка КАК ПеремРасходСсылка,
	|		ВТРеалИПеремПродажа.ПеремКоличество КАК ПеремРасходКоличество,
	|		ВТРеалИПеремПродажа.РеалСсылка КАК РеалСсылка,
	|		ВТРеалИПеремПродажа.РеалКоличество КАК РеалКоличество,
	|
	|		ВТРеалИПеремПродажа.РеалАкцизВиноград КАК РеалАкцизВиноград,
	|		ВТРеалИПеремПродажа.РеалВычетАкциз КАК РеалВычетАкциз,
	|		ВТРеалИПеремПродажа.ПеремАкцизВиноград КАК ПеремАкцизВиноград,
	|		ВТРеалИПеремПродажа.ПеремВычетАкциз КАК ПеремВычетАкциз,
	|
	|		ВТОТИПеремещениеНаСклад.Виноматериал КАК ОТВиноматериал,
	|		ВТОТИПеремещениеНаСклад.ОТКоличество КАК ОТКоличество,
	|		ВТОТИПеремещениеНаСклад.ПеремСсылка КАК ПеремПриходСсылка,
	|		ВТОТИПеремещениеНаСклад.ПеремКоличество КАК ПеремПриходКоличество
	|	ПОМЕСТИТЬ ВТОсновная
	|	ИЗ
	|		ВТРеалИПеремПродажа КАК ВТРеалИПеремПродажа
	|			ПОЛНОЕ СОЕДИНЕНИЕ ВТОТИПеремещениеНаСклад КАК ВТОТИПеремещениеНаСклад
	|			ПО ВТРеалИПеремПродажа.ДокументПроизводства = ВТОТИПеремещениеНаСклад.ОтчетПроизводства
	|				И ВТРеалИПеремПродажа.Номенклатура = ВТОТИПеремещениеНаСклад.Номенклатура
	|;
	|
	|// 10 Добавляем Показатели (Остаток, Дт43, Кт43) к Результату шага 9 (соединяем по Номенклатуре)
	|	ВЫБРАТЬ
	|		Основная.ОтчетПроизводства КАК ОтчетПроизводства,
	|		Основная.ДатаРозлива КАК ДатаРозлива,
	|		Основная.Номенклатура КАК Номенклатура,
	|		Основная.Номенклатура.КодЕГАИС КАК КодЕГАИС,
	|		Основная.ПеремРасходСсылка КАК ПеремРасходСсылка,
	|		Основная.ПеремРасходКоличество КАК ПеремРасходКоличество,
	|		Основная.РеалСсылка КАК РеалСсылка,
	|		Основная.РеалКоличество КАК РеалКоличество,
	|
	|		Основная.РеалАкцизВиноград КАК РеалАкцизВиноград,
	|		Основная.РеалВычетАкциз КАК РеалВычетАкциз,
	|		Основная.ПеремАкцизВиноград КАК ПеремАкцизВиноград,
	|		Основная.ПеремВычетАкциз КАК ПеремВычетАкциз,
	|
	|		Основная.ОТВиноматериал КАК ОТВиноматериал,
	|		Основная.ОТВиноматериал.КодЕГАИС КАК ОТВиноматериалКодЕГАИС,
	|		Основная.ОТКоличество КАК ОТКоличество,
	|		Основная.ПеремПриходСсылка КАК ПеремПриходСсылка,
	|		Основная.ПеремПриходКоличество КАК ПеремПриходКоличество,
	|		Остатки.Остаток КАК Остаток,
	|		Остатки.Дт43 КАК Дт43,
	|		Остатки.Кр43 КАК Кр43
	|	ПОМЕСТИТЬ ВТРезультат
	|	ИЗ
	|		ВТОсновная КАК Основная
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТХозрасчетный КАК Остатки
	|			ПО (Остатки.Номенклатура = Основная.Номенклатура)
	|;
	|	
	|
	|// 11 Добавляем Показатели из Алкоголь доп. сведения (переводим в литры), соединяем по Номенклатуре
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		Результат.ДатаРозлива КАК Период,
	|		Результат.Номенклатура КАК Номенклатура,
	|		Результат.КодЕГАИС КАК КодЕГАИС,
	|		Результат.ПеремРасходСсылка КАК ПеремРасходСсылка,
	|		Результат.ПеремРасходСсылка.СкладПолучатель КАК ПеремСкладПолучательСсылка,
	|		Результат.ПеремРасходСсылка.СкладПолучатель.КППСклада КАК ПеремСкладПолучательКПП,
	|		Результат.ПеремРасходКоличество КАК ПеремРасходКоличество,
	|		Результат.ПеремРасходКоличество * НоменклатуаС2015.Объем КАК ПеремРасходЛитр,
	|		Результат.РеалСсылка КАК РеалСсылка,
	|		Результат.РеалСсылка.Контрагент КАК РеалКонтрагентСсылка,
	|		Результат.РеалСсылка.Контрагент.ИНН КАК РеалКонтрагентИНН,
	|		Результат.РеалСсылка.Контрагент.КПП КАК РеалКонтрагентКПП,
	|		Результат.РеалКоличество КАК РеалКоличество,
	|
	|		Результат.РеалАкцизВиноград КАК РеалАкцизВиноград,
	|		Результат.РеалВычетАкциз КАК РеалВычетАкциз,
	|		Результат.ПеремАкцизВиноград КАК ПеремАкцизВиноград,
	|		Результат.ПеремВычетАкциз КАК ПеремВычетАкциз,
	|	
	|		Результат.РеалКоличество * НоменклатуаС2015.Объем КАК РеалЛитр,
	|		Результат.ОтчетПроизводства КАК ОтчетПроизводства,
	|		Результат.ОТВиноматериал КАК ОТВиноматериал,
	|		Результат.ОТВиноматериалКодЕГАИС КАК ОТВиноматериалКодЕГАИС,
	|		Результат.ОТКоличество КАК ОТКоличество,
	|		Результат.ОТКоличество * НоменклатуаС2015.Объем КАК ОТЛитр,
	|		Результат.ПеремПриходСсылка КАК ПеремПриходСсылка,
	|		Результат.ПеремПриходКоличество КАК ПеремПриходКоличество,
	|		Результат.ПеремПриходКоличество * НоменклатуаС2015.Объем КАК ПеремПриходЛитр,
	|		НоменклатуаС2015.АкцизКод   КАК АкцизКод,
	|		НоменклатуаС2015.КоэффКГВП 	КАК КоэффКГВП,
	|		НоменклатуаС2015.КоэффКВ 	КАК КоэффКВ,
	|		Результат.Остаток КАК Остаток,
	|		Результат.Дт43 КАК Дт43,
	|		Результат.Кр43 КАК Кр43
	|		ПОМЕСТИТЬ ВТРезультатПолная
	|	ИЗ
	|		ВТРезультат КАК Результат
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТСведенияАлкоголь КАК НоменклатуаС2015
	|			ПО Результат.Номенклатура = НоменклатуаС2015.Номенклатура
	|	
	|;
	|
	|// 12 ВЫБОР АВИЗОВОК (ОБЕРТКА)
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ХозрасчетныйОстаткиИОбороты.Регистратор.Номер КАК НомерАвизо,
	|	ХозрасчетныйОстаткиИОбороты.Регистратор.Дата КАК ДатаАвизо,
	|	ХозрасчетныйОстаткиИОбороты.СчетДт КАК счетПрихода,
	|	ХозрасчетныйОстаткиИОбороты.СубконтоДт1 КАК ВМ,
	|	ХозрасчетныйОстаткиИОбороты.СчетКт КАК счетРасхода,
	|	ХозрасчетныйОстаткиИОбороты.СубконтоКт1 КАК Отправитель
	|ПОМЕСТИТЬ ВТАвизо
	|ИЗ
	|	РегистрБухгалтерии.Хозрасчетный.ДвиженияССубконто(
	|			,
	|			КОНЕЦПЕРИОДА(&датаКонец, ДЕНЬ),
	|			Счет В ИЕРАРХИИ (&счетПрихода)
	|				И СчетДт В ИЕРАРХИИ (&счетПрихода)
	|				И СчетКт В ИЕРАРХИИ (&счетРасхода)
	|				И СубконтоДт1 В (ВЫБРАТЬ ОТВиноматериал ИЗ ВТРезультатПолная)
	|				,
	|				,					
	|			) КАК ХозрасчетныйОстаткиИОбороты
	|;
    |
	|
	|// 12.1 АВИЗО С ОТБОРОМ
	|ВЫБРАТЬ
	|    ВТАвизо.НомерАвизо КАК НомерАвизо,
	|	МАКСИМУМ(ВТАвизо.ДатаАвизо) КАК ДатаАвизо,
	|	ВТАвизо.счетПрихода КАК счетПрихода,
	|	ВТАвизо.ВМ КАК ВМ,
	|	ВТАвизо.счетРасхода КАК счетРасхода,
	|	ВТАвизо.Отправитель КАК Отправитель
	|    ПОМЕСТИТЬ ВТАвизоСОТБОРОМ
	|ИЗ
	|    ВТАвизо КАК ВТАвизо
	|СГРУППИРОВАТЬ ПО
	|	ВТАвизо.НомерАвизо,
	|	ВТАвизо.счетПрихода,
	|	ВТАвизо.ВМ,
	|	ВТАвизо.счетРасхода,
	|	ВТАвизо.Отправитель    	
	|;
    |
	|
	|// 'ОБОРАЧИВАЕМ' РЕЗУЛЬТАТ ПРЕЖНЕЙ ВЕРСИИ ОБРАБОТКИ СОЕДИНЯЕМ С ВЫБОРКОЙ АВИЗОВОК
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВТРезультатПолная.*,
	|	ВТАвизоСОТБОРОМ.НомерАвизо КАК НомерАвизо,
	|	ВТАвизоСОТБОРОМ.ДатаАвизо КАК ДатаАвизо,
	|	ВТАвизоСОТБОРОМ.счетПрихода КАК счетПрихода,
	|	ВТАвизоСОТБОРОМ.ВМ КАК ВМ,
	|	ВТАвизоСОТБОРОМ.счетРасхода КАК счетРасхода,
	|	ВТАвизоСОТБОРОМ.Отправитель КАК Отправитель
	|ИЗ
	|	ВТРезультатПолная КАК ВТРезультатПолная
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТАвизоСОТБОРОМ КАК ВТАвизоСОТБОРОМ
	|		ПО ВТРезультатПолная.ОТВиноматериал = ВТАвизоСОТБОРОМ.ВМ			
	|	
	|УПОРЯДОЧИТЬ ПО
	|	ВТРезультатПолная.Номенклатура,
	|	ВТРезультатПолная.Период УБЫВ";
		
	Запрос.УстановитьПараметр("ОргСсылка",  Объект.Организация);
	Запрос.УстановитьПараметр("ГодУрожая", 		 Объект.ГодУрожая);
	Запрос.УстановитьПараметр("Счет",   		 Объект.СчетОстатков);
	Запрос.УстановитьПараметр("ВыбСклад",  		 Объект.СкладОстатков);
	Запрос.УстановитьПараметр("ВыбЦехЗатрат",    Объект.ПодразделениеЗатрат);
	Запрос.УстановитьПараметр("датаНач",   		 Объект.ПериодКР43.ДатаНачала);
	Запрос.УстановитьПараметр("датаКонец", 		 Объект.ПериодКР43.ДатаОкончания);
	Запрос.УстановитьПараметр("счетПрихода", 	 Объект.счетПрихода);
	Запрос.УстановитьПараметр("счетРасхода", 	 Объект.счетРасхода);

	
	РезультатЗапроса = Запрос.Выполнить();
	ОбработкаРезультатаЗапроса(РезультатЗапроса);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаРезультатаЗапроса(РезультатЗапроса)
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Объект.ТабДок.Очистить();
	Макет = ПолучитьМакетНаСервере();
	
	областьДанныеТолькоРеализация = Макет.ПолучитьОбласть("ДанныеТолькоРеализация");
	
	ОблЗаголовок = Макет.ПолучитьОбласть("Заголовок");	
	Объект.ТабДок.Вывести(ОблЗаголовок);
	
	ОблЗаголовокДанные = Макет.ПолучитьОбласть("ДанныеЗаголовок");
	Объект.ТабДок.Вывести(ОблЗаголовокДанные);
	
	ОблДанныеШапка  = Макет.ПолучитьОбласть("ДанныеШапка");
	ОблДанныеВсе    = Макет.ПолучитьОбласть("ДанныеВсе");
	ОблДанныеОтчеты = Макет.ПолучитьОбласть("ДанныеОтчеты");
	
	текКодЕГАИСПродукции = "";
	
	// Повторы
	ОтчетПроизводстваСсылка 	  = Документы.ОтчетПроизводстваЗаСмену.ПустаяСсылка();
	ОтчетПроизводстваКоличество   = 0;
	ОтчетПроизводстваВиноматериал = Справочники.Номенклатура.ПустаяСсылка();
	повторОтчетаПроизводства      = Ложь;
	
	ПеремПриходСсылка		 	  = Документы.ПеремещениеТоваров.ПустаяСсылка();
	ПеремПриходСсылкаКоличество   = 0;
	повторПеремПриходСсылка       = Ложь;
	
	Пока Выборка.СледующийПоЗначениюПоля("Номенклатура") Цикл

		// Накопительные параметры
		// Приход
		ОТКоличество = 0; 
		ПРПриход     = 0;
		// Расход
		Реализация   = 0;
		ПРРасход	 = 0;
		
		первыйИБолееДокРасхода = ЛОЖЬ;
		
		ОблДанныеШапка.Параметры.Заполнить(Выборка);
		Объект.ТабДок.Вывести(ОблДанныеШапка);
		
		массивРеал		  = Новый Массив;
		массивПеремРасход = Новый Массив;
		
		массивОТ		  = Новый Массив;
		массивПеремПриход = Новый Массив;
		
		
		Пока Выборка.Следующий() Цикл
			
			// Может быть NULL
			ВыборкаОстаток = ?(Выборка.Остаток = NULL, 0, Число(Выборка.Остаток) );
			ВыборкаДт43    = ?(Выборка.Дт43 = NULL,    0, Число(Выборка.Дт43) );
			ВыборкаКр43    = ?(Выборка.Кр43 = NULL,    0, Число(Выборка.Кр43) );
			
			
			ВыборкаОТКоличество = ?(Выборка.ОТКоличество = NULL, 0, Число(Выборка.ОТКоличество) );
			ВыборкаПеремПриходКоличество = ?(Выборка.ПеремПриходКоличество = NULL, 0, Число(Выборка.ПеремПриходКоличество) );
			
			ВыборкаРеалКоличество = ?(Выборка.РеалКоличество = NULL, 0, Число(Выборка.РеалКоличество) );
			ВыборкаПеремРасходКоличество = ?(Выборка.ПеремРасходКоличество = NULL, 0, Число(Выборка.ПеремРасходКоличество) );
			
			// Выборка.Период - это дата розлива.
			
			// Расход
			ДокРеализацияУжеУчитывался = ДокУжеУчитывался(Выборка.РеалСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаРеалКоличество, Выборка.ОтчетПроизводства, массивРеал);
			Если НЕ ДокРеализацияУжеУчитывался Тогда
				Реализация = Реализация + ВыборкаРеалКоличество;
				массивРеал.Добавить( Новый Структура("ДокСсылка,ДокДатаРозлива,Номенклатура,Количество,ОтчетПроизводства", Выборка.РеалСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаРеалКоличество, Выборка.ОтчетПроизводства) );
			КонецЕсли; 
			
			ДокПРРасходУжеУчитывался = ДокУжеУчитывался(Выборка.ПеремРасходСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаПеремРасходКоличество, Выборка.ОтчетПроизводства, массивПеремРасход);
			Если НЕ ДокПРРасходУжеУчитывался Тогда
				ПРРасход = ПРРасход + ВыборкаПеремРасходКоличество;
				массивПеремРасход.Добавить( Новый Структура("ДокСсылка,ДокДатаРозлива,Номенклатура,Количество,ОтчетПроизводства", Выборка.ПеремРасходСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаПеремРасходКоличество, Выборка.ОтчетПроизводства) );
			КонецЕсли;
			
			
			// НЕ показывать те "ОТ" и "Перемещения Приходы на склад" - дата которых больше даты Реализации и Перемещения от склада
			расходЗаполнен = ЗначениеЗаполнено(Выборка.ПеремРасходСсылка) ИЛИ ЗначениеЗаполнено(Выборка.РеалСсылка);
			Если НЕ первыйИБолееДокРасхода И НЕ расходЗаполнен Тогда
				Продолжить;
			КонецЕсли;			
			первыйИБолееДокРасхода = ИСТИНА;
			
			// Приход
			// ОТКоличество = ОТКоличество + ВыборкаОТКоличество;
			// ПРПриход     = ПРПриход + ВыборкаПеремПриходКоличество;			
			// Приход
			ДокОТУжеУчитывался = ДокУжеУчитывался(Выборка.ОтчетПроизводства, Выборка.Период, Выборка.Номенклатура, ВыборкаОТКоличество, Выборка.ОтчетПроизводства, массивОТ);
			Если НЕ ДокОТУжеУчитывался Тогда
				ОТКоличество = ОТКоличество + ВыборкаОТКоличество;
				массивОТ.Добавить( Новый Структура("ДокСсылка,ДокДатаРозлива,Номенклатура,Количество,ОтчетПроизводства", Выборка.РеалСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаОТКоличество, Выборка.ОтчетПроизводства) );
			КонецЕсли; 
			
			ДокПРПриходУжеУчитывался = ДокУжеУчитывался(Выборка.ПеремПриходСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаПеремПриходКоличество, Выборка.ОтчетПроизводства, массивПеремПриход);
			Если НЕ ДокПРПриходУжеУчитывался Тогда
				ПРПриход     = ПРПриход + ВыборкаПеремПриходКоличество;
				массивПеремПриход.Добавить( Новый Структура("ДокСсылка,ДокДатаРозлива,Номенклатура,Количество,ОтчетПроизводства", Выборка.ПеремРасходСсылка, Выборка.Период, Выборка.Номенклатура, ВыборкаПеремПриходКоличество, Выборка.ОтчетПроизводства) );
			КонецЕсли;

			
			
			
			// Фильтрация Приход
			// ОТИсчерпан  = ?(ОТКоличество > ВыборкаДт43 И ОТКоличество - ВыборкаОТКоличество  >= ВыборкаДт43, Истина, Ложь);
			// ПРПИсчерпан = ?(ПРПриход > ВыборкаДт43 И ПРПриход - ВыборкаПеремПриходКоличество >= ВыборкаДт43, Истина, Ложь);
			// В данном случаи необходимо смотреть на Количество реализованной и показывать Приход пока он не привысит расход 
			ОТИсчерпан  = ?(ОТКоличество > ВыборкаКр43 И ОТКоличество - ВыборкаОТКоличество  		 >= ВыборкаКр43 ИЛИ ДокОТУжеУчитывался, 	  Истина, Ложь);
			ПРПИсчерпан = ?(ПРПриход 	 > ВыборкаКр43 И ПРПриход 	  - ВыборкаПеремПриходКоличество >= ВыборкаКр43 ИЛИ ДокПРПриходУжеУчитывался, Истина, Ложь);
						
			// Фильтрация Расход
			РИсчерпан 	= ?(Реализация > ВыборкаКр43 И Реализация - ВыборкаРеалКоличество 	 	 >= ВыборкаКр43 ИЛИ ДокРеализацияУжеУчитывался, Истина, Ложь);
			ПРРИсчерпан = ?(ПРРасход   > ВыборкаКр43 И ПРРасход   - ВыборкаПеремРасходКоличество >= ВыборкаКр43 ИЛИ ДокПРРасходУжеУчитывался, 	Истина, Ложь);
			
			ЗаполнитьОбластьМакета(ОблДанныеОтчеты, областьДанныеТолькоРеализация, Выборка, "ОблДанныеОтчеты", ОТИсчерпан, ПРПИсчерпан, РИсчерпан, ПРРИсчерпан);	
			
		КонецЦикла;
	КонецЦикла;

		                                                          
КонецПроцедуры

&НаСервере
Функция ДокУжеУчитывался(элементПоиска, датаРозлива, НомСсылка, колДокумента, ОтчетПроизводства, массивИскомых)
	// датаРозлива в запросе как Выборка.Период
	Если колДокумента = 0 Тогда	
		Возврат ИСТИНА;	
	КонецЕсли; 
	
	Для каждого э Из массивИскомых Цикл	
		Если элементПоиска = э.ДокСсылка И датаРозлива = э.ДокДатаРозлива И НомСсылка = э.Номенклатура И колДокумента = э.Количество И ОтчетПроизводства = э.ОтчетПроизводства Тогда
			Возврат ИСТИНА;
		КонецЕсли;	
	КонецЦикла; 
	
	Возврат ЛОЖЬ;
КонецФункции

&НаКлиенте
Процедура Сформировать(Команда)
	СформироватьНаСервере();	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Объект.Организация = Справочники.Организации.НайтиОрганизацию("9103094582", "910301001");
	Объект.ПериодКР43.ДатаНачала 	= Дата("20200101000000");  // 01.01.2020 00:00:00
	Объект.ПериодКР43.ДатаОкончания = Дата("20200131235959");  // 31.01.2020 23:59:59
	Объект.ГодУрожая = 2015;
	Объект.СчетОстатков = ПланыСчетов.Хозрасчетный.НайтиПоКоду(43);
	Объект.СкладОстатков = Справочники.Склады.НайтиПоКоду("БП-002926");
	Объект.ПодразделениеЗатрат = Справочники.Склады.НайтиПоКоду("БП-002916");
	
	Объект.счетПрихода = ПланыСчетов.Хозрасчетный.НайтиПоКоду(21);
	Объект.счетРасхода = ПланыСчетов.Хозрасчетный.НайтиПоКоду(79);
	
	Объект.ТабДок.ФиксацияСверху = 3;
    Объект.ТабДок.ФиксацияСлева  = 4;	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОбластьДанныхРасход(Выборка, область)
	
	обк3 = Выборка.РеалСсылка.ПолучитьОбъект();
	область.Параметры.ТипДокумента 		     	= "Опт";
	область.Параметры.КонтрагентРасходСсылка 	= Выборка.РеалКонтрагентСсылка;
	область.Параметры.КонтрагентРасходИНН    	= Выборка.РеалКонтрагентИНН;
	область.Параметры.КонтрагентРасходКПП    	= Выборка.РеалКонтрагентКПП;
	область.Параметры.ДокументРасходСсылка   	= обк3.Номер;
	область.Параметры.ДокументРасходДата     	= обк3.Дата;
	область.Параметры.РасходЛитры 		     	= Выборка.РеалЛитр;

	область.Параметры.РасходКоличество 	     	= Выборка.РеалКоличество;	
	РасходЛитры 								= ?(Выборка.РеалЛитр = NULL, Число(Выборка.ПеремРасходЛитр), Число(Выборка.РеалЛитр) );
	область.Параметры.Тонн						=  РасходЛитры / 1000;
	
	область.Параметры.АкцизВинограда 	     	= ?(Выборка.РеалАкцизВиноград = NULL,    0, Число(Выборка.РеалАкцизВиноград) );
	область.Параметры.ВычетАкциза 	         	= ?(Выборка.РеалВычетАкциз = NULL,       0, Число(Выборка.РеалВычетАкциз) );
	
КонецПроцедуры
			
&НаСервере
Процедура ОчиститьОбластьДанныхРасход(область)
	
	область.Параметры.ТипДокумента 		     	= "";
	область.Параметры.КонтрагентРасходСсылка 	= "";
	область.Параметры.КонтрагентРасходИНН    	= "";
	область.Параметры.КонтрагентРасходКПП    	= "";
	область.Параметры.ДокументРасходСсылка   	= "";
	область.Параметры.ДокументРасходДата     	= "";
	область.Параметры.РасходЛитры 		     	= "";
	область.Параметры.РасходКоличество 	     	= "";
	
	область.Параметры.Тонн						= "";
	область.Параметры.АкцизВинограда 	     	= "";
	область.Параметры.ВычетАкциза 	         	= "";
	
КонецПроцедуры
 

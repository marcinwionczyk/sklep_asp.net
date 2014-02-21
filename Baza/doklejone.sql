/*==============================================================*/
/* Table: Kategoria                                             */
/*==============================================================*/
create table Kategoria (
   kategoriaID          int                  identity(1, 1),
   nadkategoriaID       int                  not null,
   KatNazwa             varchar(50)          collate Polish_CI_AS not null
)
on "PRIMARY"
go

alter table Kategoria
   add constraint PK_KATEGORIA primary key nonclustered (kategoriaID)
      on "PRIMARY"
go

/*==============================================================*/
/* Table: Towary                                                */
/*==============================================================*/
create table Towary (
   TowarID              uniqueidentifier     RowGuidCol not null default newid(),
   kategoriaID          int                  null,
   TowarNazwa           varchar(50)          collate Polish_CI_AS not null,
   Opistowaru           ntext                collate Polish_CI_AS null,
   Jednostkamiary       varchar(10)          collate Polish_CI_AS null,
   cenajednostkowa      money                null,
   Aktualnailosc        smallint             null
)
on "PRIMARY"
go

alter table Towary
   add constraint PK_TOWARY primary key nonclustered (TowarID)
      on "PRIMARY"
go

/*==============================================================*/
/* Table: składasiez                                            */
/*==============================================================*/
create table składasiez (
   TowarID              uniqueidentifier     not null,
   TransakcjaID         uniqueidentifier     not null,
   ilosc                smallint             null,
   cenajednostkowa      money                null
)
on "PRIMARY"
go

alter table składasiez
   add constraint PK_SKŁADASIEZ primary key (TowarID, TransakcjaID)
      on "PRIMARY"
go

/*==============================================================*/
/* Table: zamowieniaKlientow                                    */
/*==============================================================*/
create table zamowieniaKlientow (
   TransakcjaID         uniqueidentifier     RowGuidCol not null default newid(),
   UserId               uniqueidentifier     not null default newid(),
   formaPlatnosci       varchar(50)          collate Polish_CI_AS null
      constraint CKC_FORMAPLATNOSCI_ZAMOWIEN check (formaPlatnosci is null or (formaPlatnosci in ('przelew','gotówka','za pobraniem'))),
   statuszamowienia     varchar(50)          collate Polish_CI_AS null
      constraint CKC_STATUSZAMOWIENIA_ZAMOWIEN check (statuszamowienia is null or (statuszamowienia in ('zamówienie zrealizowane','towar wysłano','wydawianie towaru','zamówienie przyjęto','oczekiwanie na zapłatę'))),
   DataZamowienia       datetime             null
)
on "PRIMARY"
go

alter table zamowieniaKlientow
   add constraint PK_ZAMOWIENIAKLIENTOW primary key nonclustered (TransakcjaID)
      on "PRIMARY"
go

alter table Towary
   add constraint FK_TOWARY_PRZYNALEŻ_KATEGORI foreign key (kategoriaID)
      references Kategoria (kategoriaID)
go


alter table składasiez
   add constraint FK_SKŁADASI_REFERENCE_TOWARY foreign key (TowarID)
      references Towary (TowarID)
go

alter table składasiez
   add constraint FK_SKŁADASI_REFERENCE_ZAMOWIEN foreign key (TransakcjaID)
      references zamowieniaKlientow (TransakcjaID)
go

alter table zamowieniaKlientow
   add constraint FK_ZAMOWIEN_REFERENCE_ASPNET_U foreign key (UserId)
      references aspnet_Users (UserId)
         on update cascade on delete cascade
go

create trigger td_kategoria on Kategoria for delete as
begin
    declare
       @numrows  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Delete all children in "składasiez"  */
    delete Towary
    from   Towary t2, deleted t1
    where  t2.kategoriaID = t1.kategoriaID


    return

/*  Errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go


create trigger ti_towary on Towary for insert as
begin
    declare
       @maxcard  int,
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Parent "Kategoria" must exist when inserting a child in "Towary"  */
    if update(kategoriaID)
    begin
       if (select count(*)
           from   Kategoria t1, inserted t2
           where  t1.kategoriaID = t2.kategoriaID) != @numrows
          begin
             select @errno  = 50002,
                    @errmsg = 'Parent does not exist in "Kategoria". Cannot create child in "Towary".'
             goto error
          end
    end

    return

/*  Errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go


create trigger tu_towary on Towary for update as
begin
   declare
      @maxcard  int,
      @ins_TowarID int,
      @del_TowarID int,
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

      /*  Parent "Kategoria" must exist when updating a child in "Towary"  */
      if update(kategoriaID)
      begin
         if (select count(*)
             from   Kategoria t1, inserted t2
             where  t1.kategoriaID = t2.kategoriaID) != @numrows
            begin
               select @errno  = 50003,
                      @errmsg = 'Kategoria" does not exist. Cannot modify child in "Towary".'
               goto error
            end
      end
      /*  Cannot modify parent code in "Towary" if children still exist in "składasiez"  */
      if update(TowarID)
      begin
         if exists (select 1
                    from   składasiez t2, inserted i1, deleted d1
                    where  t2.TowarID = d1.TowarID
                     and  (i1.TowarID != d1.TowarID))
            begin
               select @errno  = 50005,
                      @errmsg = 'Children still exist in "składasiez". Cannot modify parent code in "Towary".'
               goto error
            end
      end

      declare cIns cursor local for select 
              TowarID
          from inserted
      declare cDel cursor local for select 
              TowarID
          from deleted


      return

/*  Errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go


create trigger td_zamowieniaklientow on zamowieniaKlientow for delete as
begin
    declare
       @numrows  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Delete all children in "składasiez"  */
    delete składasiez
    from   składasiez t2, deleted t1
    where  t2.TransakcjaID = t1.TransakcjaID


    return

/*  Errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go


 create table CIR_LOG_COUNT_ADEL
 (
  CLD_DEL_KBN            integer           not null,
  CLD_DEL_YEAR           integer,
  CLD_DEL_MONTH          integer,
  CLD_AUID               integer           not null,
  CLD_ADATE              timestamp         not null,
  CLD_EUID               integer           not null,
  CLD_EDATE              timestamp         not null
 );
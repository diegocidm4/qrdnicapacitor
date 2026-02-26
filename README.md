# qrdnicapacitor

lectura y validación de códigos QR generados por la app MiDNI

## Install

```bash
npm install qrdnicapacitor
npx cap sync
```

## API

<docgen-index>

* [`configure(...)`](#configure)
* [`validaMiDNIQR(...)`](#validamidniqr)
* [`abrirEscaner()`](#abrirescaner)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### configure(...)

```typescript
configure(options: { license: string; certs?: { [key: string]: string; } | undefined; }) => Promise<EstadoLicencia>
```

| Param         | Type                                                                  |
| ------------- | --------------------------------------------------------------------- |
| **`options`** | <code>{ license: string; certs?: { [key: string]: string; }; }</code> |

**Returns:** <code>Promise&lt;<a href="#estadolicencia">EstadoLicencia</a>&gt;</code>

--------------------


### validaMiDNIQR(...)

```typescript
validaMiDNIQR(options: { data: string; }) => Promise<MiDNIData>
```

| Param         | Type                           |
| ------------- | ------------------------------ |
| **`options`** | <code>{ data: string; }</code> |

**Returns:** <code>Promise&lt;<a href="#midnidata">MiDNIData</a>&gt;</code>

--------------------


### abrirEscaner()

```typescript
abrirEscaner() => Promise<any>
```

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### Interfaces


#### EstadoLicencia

| Prop                      | Type                 |
| ------------------------- | -------------------- |
| **`descripcion`**         | <code>string</code>  |
| **`APIKeyValida`**        | <code>boolean</code> |
| **`lecturaQRHabilitada`** | <code>boolean</code> |


#### MiDNIData

| Prop                     | Type                                                                                                                                     |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **`dni`**                | <code>string</code>                                                                                                                      |
| **`name`**               | <code>string</code>                                                                                                                      |
| **`surnames`**           | <code>string</code>                                                                                                                      |
| **`birthDate`**          | <code>string</code>                                                                                                                      |
| **`expiryDate`**         | <code>string</code>                                                                                                                      |
| **`gender`**             | <code>string</code>                                                                                                                      |
| **`address`**            | <code>string</code>                                                                                                                      |
| **`nationality`**        | <code>string</code>                                                                                                                      |
| **`parents`**            | <code>string</code>                                                                                                                      |
| **`supportNumber`**      | <code>string</code>                                                                                                                      |
| **`birthPlace1`**        | <code>string</code>                                                                                                                      |
| **`birthPlace2`**        | <code>string</code>                                                                                                                      |
| **`birthPlace3`**        | <code>string</code>                                                                                                                      |
| **`photoData`**          | <code>string</code>                                                                                                                      |
| **`isAdult`**            | <code>boolean</code>                                                                                                                     |
| **`rawSignature`**       | <code>string</code>                                                                                                                      |
| **`signedData`**         | <code>string</code>                                                                                                                      |
| **`certificateRef`**     | <code>string</code>                                                                                                                      |
| **`type`**               | <code>string</code>                                                                                                                      |
| **`verificationResult`** | <code>{ status: 'VALID' \| 'INVALID' \| 'NO_CERTIFICATES' \| 'INVALID_QR' \| 'EXPIRATED_QR' \| 'UNKNOWN'; certificate?: string; }</code> |
| **`qrDataExpiry`**       | <code>string</code>                                                                                                                      |
| **`fullBirthPlace`**     | <code>string</code>                                                                                                                      |

</docgen-api>
